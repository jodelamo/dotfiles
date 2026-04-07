# GRC colorizes nifty unix tools all over the place
if (( $+commands[grc] )); then
  if [[ "$(uname)" == "Darwin" ]] && (( $+commands[brew] )); then
    source "$(brew --prefix)/etc/grc.zsh"
  elif [[ "$(uname)" == "Linux" ]] && [[ -f /etc/grc.zsh ]]; then
    source /etc/grc.zsh
  fi
fi
