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
#git stuff
alias mvnb='mvn -DskipTests -DskipITs'
alias mvnr='mvn jetty:run'
alias mvnl='MAVEN_OPTS="-Xmx8g" mvn clean package exec:java'
alias mvnln='mvnl -Dspring.profiles.active=no-media'
alias mvns='mvnr -Djetty.port=9090 -DXmx=3g'
alias gcm='git commit'
alias gcmm='git commit -m'
alias gst='git status'
alias glg='git log --pretty=oneline --decorate --graph'
alias gpl='git pull'
alias gps='git push'
alias grb='git rebase'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gfe='git fetch --all'
alias gsh='git show'
alias grm='git rm'
alias gad='git add'
alias grs='git reset'
alias gdf='git diff'
alias gbr='git branch' 
