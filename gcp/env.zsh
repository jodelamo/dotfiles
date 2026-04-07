export CLOUDSDK_PYTHON=$HOME/.pyenv/shims/python

if command -v gcloud >/dev/null 2>&1; then
  if [[ "$(uname)" == "Darwin" ]]; then
    source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
    source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
  elif [[ "$(uname)" == "Linux" ]]; then
    local gcloud_dir="/usr/share/google-cloud-sdk"
    [[ -f "$gcloud_dir/path.zsh.inc" ]] && source "$gcloud_dir/path.zsh.inc"
    [[ -f "$gcloud_dir/completion.zsh.inc" ]] && source "$gcloud_dir/completion.zsh.inc"
  fi
fi

