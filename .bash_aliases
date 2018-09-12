########
# Aliases
########

# Unix
alias ll="ls -laGh"
alias eb="vim ~/.bash_profile"
alias sb="source ~/.bash_profile"
alias ea="vim ~/.bash_aliases"
alias als="less ~/.bash_aliases"
alias cr="crun"

# Git
alias gs="git status"
alias gp="git pull"
alias vd='gitvim'
alias vds='vim `git diff --staged --name-only`'
alias gpurge='git branch --merged | grep -Ev "(\*|master)" | xargs -n 1 git branch -d'
alias co="git co"
alias grtb='git_remote_tracking_branch'
alias gclean='git_clean_branches'
alias gcom="git co master"
alias gca="git commit --amend --no-edit"

# Hub
eval "$(hub alias -s)"

# Rails
alias be="bundle exec"
alias fs="foreman start"
alias rs="rails s"
alias rc="rails c"
alias rcs="heroku run rails c -r staging"
alias rcp="heroku run rails c -r production"

# Vim
alias v="vim"

# Helpers
alias uid="uuidgen | pbcopy"

# Postgres
alias pstart="pg_ctl -D /usr/local/var/postgres start"
alias pstop="pg_ctl -D /usr/local/var/postgres stop"

# Redis
alias rstart="brew services start redis"
alias rstop="brew services stop redis"

# Git
alias gre="git reset head --hard"

# tmux
alias ta="tmux attach"

# Keyboard
alias kreset="make iris/rev2:joel:avrdude"


function crun() {
  make $1 && ./$1;
}

# -------------------------------------
#   Remote Tracking Branch
#   -> Creates a new branch and pushes that branch to remote
# -------------------------------------
#
# $1 - the branch name
#
# Usage: `git_remote_tracking_branch fix_sign_up_form_styles`
#

function git_remote_tracking_branch() {
  git checkout -b $1 && git push -u origin $1
}

# -------------------------------------
#   Git Clean Remote Branches
#   -> Deletes all branches that have been merged into master
# -------------------------------------
#

function git_clean_branches() {
  read -r -p "Are you sure you want to delete all merged branches? [y/N] " response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
  then
    git branch -r --merged master | grep -v master | cut -d/ -f2- | xargs -n 1 git push --delete origin
  fi
}


# -------------------------------------
#   Open all modified, unstaged and untracked files in new vim tabs
#   -> Excludes deleted files
# -------------------------------------
#
function gitvim {
  vim $(git status --short | grep -v D | awk ' { print $2 } ')
}
