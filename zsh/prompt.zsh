setopt promptsubst

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' formats '[%b%m]%u%c'
zstyle ':vcs_info:git*+set-message:*' hooks git-st git-untracked
# zstyle ':vcs_info:*+*:*' debug true

# Show "?" if we have untracked files
# Ref: https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples#L163
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
    hook_com[staged]+='?'
  fi
}

# Show number of commits ahead-of or behind
# Ref: https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples#L180
+vi-git-st() {
  local ahead behind
  local -a gitstatus

  # Exit early in case the worktree is on a detached HEAD
  git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

  local -a ahead_and_behind=(
    $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
  )

  ahead=${ahead_and_behind[1]}
  behind=${ahead_and_behind[2]}

  (( $ahead )) && gitstatus+=( " ↑" )
  (( $behind )) && gitstatus+=( "↓" )

  hook_com[misc]+=${(j:/:)gitstatus}
}

precmd() {
  local newline=$'\n'

  vcs_info

  if [[ -z ${vcs_info_msg_0_} ]]; then
    PROMPT="${newline}%B%F{cyan}%~%f%b %# "
  else
    PROMPT="${newline}%B%F{cyan}%~%f%b %F{yellow}${vcs_info_msg_0_}%f %# "
  fi
}
