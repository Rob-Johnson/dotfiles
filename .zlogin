#ps aux | grep 'gpg-agent --daemon' |grep -v grep &> /dev/null
#if [ ! $? -eq 0 ]; then
  #eval $(gpg-agent --daemon --use-standard-socket --enable-ssh-support --write-env-file "/Users/robj/.gpg-agent-info")
#  eval $(gpg-agent --daemon --use-standard-socket --write-env-file "/Users/robj/.gpg-agent-info")
#fi
