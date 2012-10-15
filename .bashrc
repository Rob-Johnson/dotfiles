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


# Add bash aliases.
if [ -f ~/.bash_aliases ]; then
      source ~/.bash_aliases
fi
