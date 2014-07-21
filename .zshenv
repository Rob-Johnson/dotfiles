export EDITOR=vim
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export GOPATH="$HOME/workspace/go-workspace"
export PATH=$HOME/.rbenv/bin:/usr/local/bin:$GOPATH/bin:/usr/local/sbin:/usr/sbin:/sbin:$HOME/bin:$PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PYTHONSTARTUP=~/.pythonrc
if [ -f "$HOME/.api_keys" ]; then
  source ~/.api_keys
fi

