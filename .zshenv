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

# Go workspace (GOROOT set in .zprofile after brew is in PATH)
export GOPATH="${GOPATH:-$HOME/go}"
[[ ! -d "$GOPATH" ]] && mkdir -p "$GOPATH"

# Create workspace directory structure
[[ ! -d "$HOME/workspace" ]] && mkdir -p "$HOME/workspace"

# Ansible configuration (modern collections-based approach)
if command -v ansible >/dev/null 2>&1; then
  export ANSIBLE_COLLECTIONS_PATH="$HOME/.ansible/collections"
fi
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
