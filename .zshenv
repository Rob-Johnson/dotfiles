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

# Go configuration (modules mode - Go 1.11+)
if command -v go >/dev/null 2>&1; then
  export GOROOT="$(go env GOROOT 2>/dev/null)"
  # Modern Go uses modules, not GOPATH workspace mode
  # But still need GOPATH for tools and legacy projects
  export GOPATH="${GOPATH:-$HOME/go}"
  # Create Go workspace directory if it doesn't exist
  [[ ! -d "$GOPATH" ]] && mkdir -p "$GOPATH"
fi

# Create workspace directory structure
[[ ! -d "$HOME/workspace" ]] && mkdir -p "$HOME/workspace"

# Enhanced PATH with platform detection
typeset -U path  # Remove duplicates automatically
path=(
  $HOME/bin
  /opt/homebrew/bin        # macOS Homebrew (Apple Silicon)
  /usr/local/bin           # macOS Homebrew (Intel) / Linux
  /usr/local/opt/gnu-tar/libexec/gnubin  # GNU tar on macOS
  $HOME/.rbenv/bin
  $HOME/.local/bin         # Poetry, pipx, and other Python tools
  ${GOPATH:-$HOME/go}/bin  # Go tools and binaries
  $GOROOT/bin              # Go compiler and standard tools
  /usr/local/sbin
  /usr/sbin
  /sbin
  $path  # Keep existing PATH entries
)
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
# Python environment setup
if [[ -d "$HOME/.pyenv" ]]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
  fi
fi

# Modern Python tooling
if command -v poetry >/dev/null 2>&1; then
  # Poetry completions
  fpath=(~/.zfunc $fpath)
fi

# Node.js version management (if using nvm)
if [[ -d "$HOME/.nvm" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Rust environment
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi
