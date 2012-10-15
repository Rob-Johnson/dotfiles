
#add timestamps to bash history
export HISTTIMEFORMAT="%F %T "
# Specify history size, default 500
export HISTSIZE=8000
# History items to ignore
export HISTIGNORE="histor*:h"

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
