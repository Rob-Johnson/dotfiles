autoload colors && colors
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

##load any config files
for file in $(ls ~/*.zsh)
do
  source $file
done

autoload -U compinit && compinit
function directory_name
{
    echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

function ruby_version
{
  if which rbenv &> /dev/null; then
    echo "%{$fg_bold[red]%}$(rbenv version 2>/dev/null| awk '{print $1}')%{$reset_color%}"
  fi
}

function git_branch {
  echo "%{$fg_bold[yellow]%}$(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})%{$reset_color%}"
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

function discovery {
  curl -w "\n" https://discovery.etcd.io/new
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


PROMPT='$(ruby_version) in $(directory_name) $(git_branch) >> '
