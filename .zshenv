# Enhanced environment setup with cross-platform compatibility
# Ghostty terminal optimization
if [[ "$TERM" == "xterm-ghostty" ]]; then
  # Ensure proper terminal capabilities are recognized
  export COLORTERM=truecolor
fi

export EDITOR=vim

# Java setup (macOS only, with fallback)
if [[ "$OSTYPE" == darwin* ]] && command -v /usr/libexec/java_home >/dev/null 2>&1; then
  export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null || echo '')"
fi

# Go configuration
export GOPATH="$HOME/workspace/go-workspace"
export GOSRC="$HOME/workspace/go/bin"
if command -v go >/dev/null 2>&1; then
  export GOROOT="$(go env GOROOT 2>/dev/null)"
fi

# Enhanced PATH with platform detection
typeset -U path  # Remove duplicates automatically
path=(
  $HOME/bin
  /opt/homebrew/bin        # macOS Homebrew (Apple Silicon)
  /usr/local/bin           # macOS Homebrew (Intel) / Linux
  /usr/local/opt/gnu-tar/libexec/gnubin  # GNU tar on macOS
  $HOME/.rbenv/bin
  $GOSRC
  $GOPATH/bin
  $GOROOT/bin
  /usr/local/sbin
  /usr/sbin
  /sbin
  $path  # Keep existing PATH entries
)
export ANSIBLE_LIBRARY=~/workspace/ansible-modules-core:~/workspace/ansible-modules-extras
export LESS="-nXR"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PYTHONSTARTUP=~/.pythonrc
if [ -f "$HOME/.api_keys" ]; then
  source ~/.api_keys
fi

if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
fi

GPG_TTY=$(tty)
export GPG_TTY
# Python environment setup
if [[ -d "$HOME/.pyenv" ]]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
  fi
fi
