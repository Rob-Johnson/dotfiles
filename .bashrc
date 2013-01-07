#add timestamps to bash history
export HISTTIMEFORMAT="%F %T "
# Specify history size, default 500
export HISTSIZE=8000
# History items to ignore
export HISTIGNORE="histor*:h"
#editor as Vi
export EDITOR=vim
#A cool $PS1


#Add bash aliases
if [ -f ~/.bash_aliases ]; then
source ~/.bash_aliases
fi

# Add work bash aliases.
if [ -f ~/.work_bash_aliases ]; then
source ~/.work_bash_aliases
fi

#vi mode
set -o vi

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(git::\1)/'
}
parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "(svn::"$1 "/" $2 ")"}'
}
parse_svn_url() {
  svn info 2>/dev/null | grep -e '^URL*' | sed -e 's#^URL: *\(.*\)#\1#g '
}
parse_svn_repository_root() {
  svn info 2>/dev/null | grep -e '^Repository Root:*' | sed -e 's#^Repository Root: *\(.*\)#\1\/#g '
}
export PS1="\[\033[00m\]\u@\h\[\033[01;34m\] \w \[\033[31m\]\$(parse_git_branch)\$(parse_svn_branch) \[\033[00m\]$\[\033[00m\] "

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_10.jdk/Contents/Home"

#rbenv
export PATH="/usr/local/bin:$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
