#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
socket="dotfiles-tmux-reload-$$"

cleanup() {
  tmux -L "$socket" kill-server 2>/dev/null || true
}
trap cleanup EXIT

tmux -L "$socket" -f "$repo_dir/.tmux.conf" new-session -d
for _ in 1 2 3; do
  tmux -L "$socket" source-file "$repo_dir/.tmux.conf"
done

features="$(tmux -L "$socket" show-options -gv terminal-features)"
overrides="$(tmux -L "$socket" show-options -gv terminal-overrides)"

count() {
  grep -o "$1" | wc -l | tr -d ' '
}

[[ "$(count 'xterm-ghostty:' <<<"$features")" == 1 ]]
[[ "$(count 'tmux-256color:' <<<"$features")" == 1 ]]
[[ "$(count 'tmux-256color:Ms=' <<<"$overrides")" == 1 ]]
