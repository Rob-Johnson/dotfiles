export EDITOR=vim
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_15.jdk/Contents/Home"
export GOPATH="$HOME/workspace/go-workspace"
export PATH=$HOME/.rbenv/bin:/usr/local/bin:$GOPATH/bin:/usr/local/sbin:/usr/sbin:/sbin:$HOME/bin:$PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PYTHONSTARTUP=~/.pythonrc
if [ -f "$HOME/.api_keys" ]; then
  source ~/.api_keys
fi

