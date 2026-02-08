# Modern ZSH configuration with Ghostty integration
# Enable Ghostty shell integration early
if [[ -n "${GHOSTTY_RESOURCES_DIR}" ]]; then
  source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi

# Load config files
# Create zsh config directory if it doesn't exist
[[ ! -d "$HOME/.config/zsh" ]] && mkdir -p "$HOME/.config/zsh"

for file in ~/.config/zsh/*.zsh(N) ~/*.zsh(N); do
  [[ -r "$file" ]] && source "$file"
done

# Poetry completions (fpath must be set before compinit)
if command -v poetry >/dev/null 2>&1; then
  fpath=(~/.zfunc $fpath)
fi

# Enhanced completion system
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Load modern completion enhancements
autoload -Uz bashcompinit && bashcompinit

# Enhanced Git prompt with status indicators
function git_info() {
  local branch_name
  local git_status
  local git_info
  
  if ! git rev-parse --git-dir &>/dev/null; then
    return 0
  fi
  
  branch_name=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  
  if [[ -n $branch_name ]]; then
    git_status=$(git status --porcelain 2>/dev/null)
    if [[ -n $git_status ]]; then
      git_info="%F{yellow}${branch_name}*%f"
    else
      git_info="%F{green}${branch_name}%f"
    fi
    echo " $git_info"
  fi
}

function fsup {
  rsync -v -e ssh $1 fs.rob-johnson.me:/var/www/fs.rob-johnson.me/
}

function client_token {
  TOKEN=`uuidgen`
  NODASHES=`echo $TOKEN | sed 's/-//g'`
  echo $TOKEN
  echo "INSERT INTO client_tokens values(UNHEX('$NODASHES'), 0);"
}

function ansible-env {
  source ~/workspace/ansible/hacking/env-setup
}

# Lots of command examples (especially heroku) lead command docs with '$' which
# make it kind of annoying to copy/paste, especially when there's multiple
# commands to copy.
#
# This hacks around the problem by making a '$' command that simply runs
# whatever arguments are passed to it. So you can copy
#   '$ echo hello world'
# and it will run 'echo hello world'
#
# taken from https://github.com/jordansissel/dotfiles/
function \$() { 
  "$@"
}

# make a best-guess at killing a container
function kill-container() { 
  docker kill $(docker ps | grep $1 | awk '{print $1}') 
}


# keep a dirstack
# https://wiki.archlinux.org/index.php/Zsh#Dirstac
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
# Create cache directory and file if they don't exist
[[ ! -d "$HOME/.cache/zsh" ]] && mkdir -p "$HOME/.cache/zsh"
[[ ! -f $DIRSTACKFILE ]] && touch $DIRSTACKFILE

if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi

chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}
DIRSTACKSIZE=50

setopt autopushd pushdsilent pushdtohome

## Remove duplicate entries
setopt pushdignoredups

### This reverts the +/- operators.
setopt pushdminus

# Enhanced prompt with Git info and exit status
PROMPT='%F{cyan}%n@%m%f:%F{blue}%~%f$(git_info) %(?..%F{red}[%?]%f )%# '

# Right prompt with timestamp (optional)
# RPROMPT='%F{242}%D{%H:%M:%S}%f'

