if (( $+commands[nodenv] )); then
  eval "$(npm completion)"
fi

PATH=node_modules/.bin:$PATH
