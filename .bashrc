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

# init rbenv
eval "$(rbenv init -)";

#functions for PS1 
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


#extra additions to path
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
#rbenv
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
#Java 7 jdk
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_10.jdk/Contents/Home"
#Ruby Path
export PATH="$PATH:/usr/local/Cellar/ruby/1.9.3-p327/bin/"

#bash auto completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

