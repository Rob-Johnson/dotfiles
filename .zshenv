export EDITOR=vim
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export GOPATH="$HOME/workspace/go-workspace"
export PATH=$HOME/.rbenv/bin:/usr/local/bin:$GOPATH/bin:/usr/local/sbin:/usr/sbin:/sbin:$HOME/bin:$PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PYTHONSTARTUP=~/.pythonrc
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/rob/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
if [ -f "$HOME/.api_keys" ]; then
  source ~/.api_keys
fi

