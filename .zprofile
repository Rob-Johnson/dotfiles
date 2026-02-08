# Homebrew (must come first so brew-installed tools are available below)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Go compiler root (needs go in PATH from Homebrew)
if command -v go >/dev/null 2>&1; then
  export GOROOT="$(go env GOROOT 2>/dev/null)"
fi

# PATH construction — after brew shellenv and path_helper so our ordering wins
typeset -U path
path=(
  $HOME/bin
  $HOME/.local/bin         # Poetry, pipx, and other Python tools
  $HOME/.bun/bin           # bun global packages (qmd, etc.)
  /opt/homebrew/bin        # macOS Homebrew (Apple Silicon)
  /usr/local/bin           # macOS Homebrew (Intel) / Linux
  /usr/local/opt/gnu-tar/libexec/gnubin  # GNU tar on macOS
  $HOME/.rbenv/bin
  ${GOPATH:-$HOME/go}/bin  # Go tools and binaries
  $GOROOT/bin              # Go compiler and standard tools
  /usr/local/sbin
  /usr/sbin
  /sbin
  $path
)

# Python environment (pyenv shims prepend to PATH, which is correct)
if [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  path=($PYENV_ROOT/bin $path)
  eval "$(pyenv init -)"
fi

# Node.js version management (nvm)
if [[ -d "$HOME/.nvm" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Rust environment
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi
