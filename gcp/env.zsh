export CLOUDSDK_PYTHON=$HOME/.pyenv/shims/python

if command -v brew >/dev/null 2>&1; then
  source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
  source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
fi

