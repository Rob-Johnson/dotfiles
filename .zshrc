##load any config files
for file in $(ls ~/*.zsh)
do
  source $file
done

autoload -U compinit && compinit

function git_branch {
  echo "$(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})"
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

# user@hostname:cur_dir git_branch %
PROMPT='%n@%m:${PWD/#$HOME/~} $(git_branch) %% '
