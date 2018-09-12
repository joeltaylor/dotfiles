########
# General
########
export VISUAL=vim
export EDITOR="$VISUAL"
export PRIDE=true

########
# Bash
########

function prompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  local RESETCOLOR="\[\e[00m\]"

  # export PS1="\n$RED\u $PURPLE@ $GREEN\w $RESETCOLOR$GREENBOLD\$(git branch 2> /dev/null)\n $BLUE[\#] → $RESETCOLOR"
  export PS1="$CYAN\w $WHITE\nλ "
}

prompt


## Git Prompt
#
 GIT_PROMPT_ONLY_IN_REPO=1
 GIT_PROMPT_SHOW_UNTRACKED_FILES=no
 GIT_PROMPT_START_USER="\[\033[0;36m\]\w\[\033[0;37m\]" # This needs to be defined in a theme to work normally.
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

gcs!() {
  git commit -m "[squash] $1" --no-verify
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

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
gb() {
  local branches branch
  branches=$(git for-each-ref --count=50 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
    branch=$(echo "$branches" |
  fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}



## Bashrc
#
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

## Golang
#
# PATH=$PATH:/usr/local/opt/go/libexec/bin

## Bin
#
PATH=./bin:$PATH

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
