export EDITOR=vim
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export GOPATH="$HOME/workspace/go-workspace"
export GOSRC="$HOME/workspace/go/bin"
export PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$HOME/.rbenv/bin:/usr/local/bin:$GOSRC:$GOPATH/bin:$GOROOT/bin:/usr/local/sbin:/usr/sbin:/sbin:$HOME/bin:$PATH
export GOROOT=`go env GOROOT`
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
export PYTHONPATH=$(brew --prefix python3)
