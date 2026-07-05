if (( $+commands[bat] )); then
  alias cat="bat --style=plain --paging=never"
elif (( $+commands[batcat] )); then
  alias cat="batcat --style=plain --paging=never"
fi
