alias cabinodecheck='#!/bin/bash

for HOST in cspcabweb03ya cspcabweb03xb; do
   echo checking solr index version on $HOST
   COMMAND="curl -s http://${HOST}:20101/replication?command=details | /opt/semantico/bin/xt | grep Version | sort -bu | wc -l"
   RESULT=$(ssh robjadm@$HOST $COMMAND)
   if [ $RESULT -gt 1 ]
       then echo SOLR INDEX OUT OF SYNC ON $HOST
       else echo OK
       echo
   fi
done'



# Aliases
alias ll='ls -l'
alias la='ls -a'
alias svim='sudo vim'
alias h='cd'
alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../..'
alias cim='vim'
alias back='cd $OLDPWD'
alias root='sudo su'
alias runlevel='sudo /sbin/init'
alias grep='grep --color=auto'
alias dfh='df -h'
alias gvim='gvim -geom 84x26'
alias start='dbus-launch startx'


#add timestamps to bash history
export HISTTIMEFORMAT="%F %T "
# Specify history size, default 500
export HISTSIZE=8000
# History items to ignore
export HISTIGNORE="histor*:h"
