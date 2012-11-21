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
alias zgrep='zgrep --color=auto'
alias mkdir='if [ -d ".git/" ] && [ "$PWD" != "/Users/$(whoami)" ]; then 
             echo remember to add this to git 
             fi 
             mkdir'
