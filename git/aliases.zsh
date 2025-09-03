gcount() {
  git diff --numstat --pretty="%H" $1 | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d\n", plus, minus)}'
}

get_default_branch() {
  git symbolic-ref --short refs/remotes/origin/HEAD | sed 's@^origin/@@'
}

alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gc="git commit"
alias gca="git commit --amend"
alias gcl="git clean -dx --force"
alias gco="git checkout"
alias gd="git diff"
alias gf="git fetch --all"
alias gm="git merge --no-ff"
alias gnames="git diff --name-only $(get_default_branch)..."
alias gpf="git push --force-with-lease"
alias gpl="git pull"
alias gpr="git pull --rebase"
alias gps="git push"
alias gr="git rebase"
alias gs="git status --short --branch"
alias gsh="git show"
alias gt="git tag -l --sort=-v:refname"
alias gundo="git reset --soft HEAD^"
