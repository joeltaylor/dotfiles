########
# General
########
export VISUAL=vim
export EDITOR="$VISUAL"
export PRIDE=true
export TERM=xterm-256color

########
# Bash
########

function prompt {
  local RESETCOLOR="\[\e[00m\]"

  # export PS1="\n$RED\u $PURPLE@ $GREEN\w $RESETCOLOR$GREENBOLD\$(git branch 2> /dev/null)\n $BLUE[\#] → $RESETCOLOR"
  export PS1="\[\e[91m\]\w\[\e[m\] $WHITE\nλ "
}

prompt


## Git Prompt
#
 GIT_PROMPT_ONLY_IN_REPO=1
 GIT_PROMPT_SHOW_UNTRACKED_FILES=no
 GIT_PROMPT_START_USER="\[\033[0;91m\]\w\[\033[0;37m\]" # This needs to be defined in a theme to work normally.
 GIT_PROMPT_BRANCH="${Yellow}"
 # GIT_PROMPT_START_ROOT="${GIT_PROMPT_START_USER}"
 GIT_PROMPT_END_USER="$WHITE\nλ "
 GIT_PROMPT_END_ROOT="${GIT_PROMPT_END_USER}"
 if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
     __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
      source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
 fi


## Git Autocomplete
#
# Downloaded from https://github.com/git/git/blob/master/contrib/completion/git-completion.bash

source ~/.git-completion.bash

## Git helper
gcs() {
  git commit -m "[squash] $1"
}

gcb() {
  git commit -m "$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')" $1
}

## NVM
#
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# ## Ag
# # Point ag to ignore file
# alias ag='ag --path-to-ignore ~/.agignore'

## FZF
#

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER=','
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# Use ag instead of the default find command for listing candidates.
# - The first argument to the function is the base path to start traversal
# - Note that ag only lists files not directories
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  ag -g "" "$1"
}

gb() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
    fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  }


## Bashrc
#
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

## Golang
#
# PATH=$PATH:/usr/local/opt/go/libexec/bin

## Bin
#
PATH=./bin:$PATH

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
