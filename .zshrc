autoload colors && colors
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

setopt PROMPT_SUBST

##load any config files
for file in $(ls *.zsh)
do
  source $file
done

function directory_name {
    echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

function ruby_version
{
  if which rbenv &> /dev/null; then
    echo "%{$fg_bold[red]%}$(rbenv version | awk '{print $1}')%{$reset_color%}"
  fi
}

function git_branch {
  echo "%{$fg_bold[yellow]%}$(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})%{$reset_color%}"
}

PROMPT='$(ruby_version) in $(directory_name) $(git_branch) > '
