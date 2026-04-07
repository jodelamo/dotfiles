if (( $+commands[goenv] )); then
  export GOENV_PATH_ORDER=front
  eval "$(goenv init -)"
fi
