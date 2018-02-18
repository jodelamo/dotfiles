alias ls="ls -F"
alias l="ls -lhA"
alias ll="ls -l"
alias la="ls -A"

alias ccat="rougify"

colors() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolor${i}\n"
  done
}

t() {
  local ignored='.git|node_modules|bower_components'
  tree -I $ignored --dirsfirst -aC $@
}
