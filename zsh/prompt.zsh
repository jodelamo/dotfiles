autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' formats '[%b]%u%c'
# zstyle ':vcs_info:*+*:*' debug true

setopt PROMPT_SUBST

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
    hook_com[staged]+='?'
  fi
}

precmd() {
  vcs_info

  if [[ -z ${vcs_info_msg_0_} ]]; then
    PROMPT="%B%F{cyan}%~%f%b %# "
  else
    PROMPT="%B%F{cyan}%~%f%b %F{magenta}${vcs_info_msg_0_}%f %# "
  fi
}
