gcount() {
  git diff --numstat --pretty="%H" $1 | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d\n", plus, minus)}'
}

alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gc="git commit"
alias gca="git commit --amend --no-edit"
alias gca="git commit --amend"
alias gcl="git clean -dx --force"
alias gco="git checkout"
alias gd="git diff"
alias gf="git fetch --all"
alias gm="git merge --no-ff"
alias gpf="git push --force-with-lease"
alias gpl="git pull"
alias gpr="git pull --rebase"
alias gps="git push"
alias gr="git rebase"
alias gs="git status --short --branch"
alias gsh="git show"
alias gt="git tag -l --sort=-v:refname"
alias gundo="git reset --soft HEAD^"

# Logging
alias glog="git log --graph --abbrev-commit --date=relative"
alias ghist="git log --pretty=format:\"%C(yellow)%h%C(reset) %C(green)%ad%C(reset) | %s%C(magenta)%d%C(reset) %C(cyan)[%an]%C(reset)\" --graph --date=short"
alias gbrag="git shortlog --summary --numbered --all"

# Clean up local branches
# Ref: https://stackoverflow.com/a/16906759/517528
alias gclean="git branch --merged main | grep -v '^[ *]*main$' | xargs git branch -d"
