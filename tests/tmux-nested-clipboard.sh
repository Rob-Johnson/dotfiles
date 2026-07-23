#!/bin/sh

set -eu

expectation=${1:---expect-propagated}
case "$expectation" in
  --expect-blocked | --expect-propagated) ;;
  *)
    echo "usage: $0 [--expect-blocked|--expect-propagated]" >&2
    exit 2
    ;;
esac

for command in tmux expect base64 ssh; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "missing test dependency: $command" >&2
    exit 2
  fi
done

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
test_host=${TMUX_TEST_HOST:-tanker}
test_port=${TMUX_TEST_PORT:-2265}
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/tmux-clipboard.XXXXXX")
outer_socket="clipboard-outer-$$"
inner_socket="clipboard-inner-$$"
remote_config="/tmp/tmux-clipboard-$$.conf"
sentinel="nested-clipboard-sentinel-$$"
encoded=$(printf '%s\n' "$sentinel" | base64 | tr -d '\r\n')
capture="$tmp_dir/terminal-output"

remote() {
  ssh -p "$test_port" -o BatchMode=yes "$test_host" "$@"
}

cleanup() {
  tmux -L "$outer_socket" kill-server 2>/dev/null || true
  remote "tmux -L '$inner_socket' kill-server; rm -f '$remote_config'" \
    >/dev/null 2>&1 || true
  if [ "${TMUX_TEST_KEEP_TMP:-0}" = 1 ]; then
    echo "kept test output in $tmp_dir" >&2
  else
    rm -rf "$tmp_dir"
  fi
}
trap cleanup EXIT HUP INT TERM

remote "cat >'$remote_config'" <"$repo_dir/.tmux.conf"
remote "tmux -L '$inner_socket' -f '$remote_config' new-session -d \"printf '%s' '$sentinel'; sleep 120\""

# The broken configuration advertises the physical terminal as tmux's output
# terminal. Force the intended TERM in reproduction mode so the test reaches
# the OSC 52 boundary instead of failing on a missing xterm-ghostty terminfo.
term_prefix=
if [ "$expectation" = "--expect-blocked" ]; then
  term_prefix="env TERM=tmux-256color "
  clipboard_wait="after 2000"
else
  clipboard_wait="expect -re $encoded"
fi

cat >"$tmp_dir/attach.exp" <<EOF
set timeout 20
spawn -noecho env TERM=xterm-ghostty tmux -L $outer_socket -f $repo_dir/.tmux.conf new-session "${term_prefix}ssh -tt -p $test_port -o BatchMode=yes $test_host 'tmux -L $inner_socket attach'"
after 500
exec sh -c { ssh -p $test_port -o BatchMode=yes $test_host 'attempt=0; client=; while test "\$attempt" -lt 300; do client=\$(tmux -L $inner_socket list-clients -F "#{client_name}"); test -n "\$client" && break; attempt=\$((attempt + 1)); sleep 0.1; done; test -n "\$client" || exit 1; sleep 1; tmux -L $inner_socket list-clients -F "#{client_termname}"; pane=\$(tmux -L $inner_socket list-panes -F "#{pane_id}"); tmux -L $inner_socket copy-mode -t "\$pane"; tmux -L $inner_socket send-keys -X -t "\$pane" start-of-line; tmux -L $inner_socket send-keys -X -t "\$pane" begin-selection; tmux -L $inner_socket send-keys -X -t "\$pane" end-of-line; tmux -L $inner_socket send-keys -X -t "\$pane" copy-selection-and-cancel' >$tmp_dir/inner-term }
$clipboard_wait
exec sh -c { client=\$(tmux -L $outer_socket list-clients -F '#{client_name}'); tmux -L $outer_socket detach-client -t "\$client" }
expect eof
EOF

if ! expect "$tmp_dir/attach.exp" >"$capture" 2>&1; then
  echo "nested tmux driver failed:" >&2
  tail -20 "$capture" >&2
  exit 1
fi

inner_buffer=$(remote "tmux -L '$inner_socket' show-buffer")
inner_term=$(cat "$tmp_dir/inner-term")
inner_prefix=$(remote "tmux -L '$inner_socket' show -gv prefix")
outer_buffer=$(tmux -L "$outer_socket" show-buffer 2>/dev/null || true)
outer_prefix=$(tmux -L "$outer_socket" show -gv prefix)

if [ "$inner_buffer" != "$sentinel" ]; then
  echo "inner tmux did not retain the copied text" >&2
  exit 1
fi
if [ "$expectation" = "--expect-blocked" ] && [ "$outer_buffer" != "$sentinel" ]; then
  echo "outer tmux did not consume the inner OSC 52 write" >&2
  exit 1
fi
if [ "$inner_term" != "tmux-256color" ]; then
  echo "inner tmux client TERM is '$inner_term', expected 'tmux-256color'" >&2
  exit 1
fi
if [ "$outer_prefix" != "C-a" ] || [ "$inner_prefix" != "C-a" ]; then
  echo "unexpected prefixes: outer=$outer_prefix inner=$inner_prefix" >&2
  exit 1
fi

if LC_ALL=C grep -aF "$encoded" "$capture" >/dev/null; then
  propagated=true
else
  propagated=false
fi

case "$expectation:$propagated" in
  --expect-blocked:false)
    echo "reproduced: outer tmux consumed OSC 52 without forwarding it"
    ;;
  --expect-propagated:true)
    echo "passed: inner tmux clipboard write reached the outer terminal"
    ;;
  --expect-blocked:true)
    echo "expected clipboard propagation to be blocked, but it succeeded" >&2
    exit 1
    ;;
  --expect-propagated:false)
    echo "inner tmux clipboard write did not reach the outer terminal" >&2
    exit 1
    ;;
esac
