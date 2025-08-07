#!/bin/sh

DEST="$HOME/.tmux/plugins/tpm"

mkdir -p "$DEST"

if [ ! -d "$DEST" ]; then
  git clone https://github.com/tmux-plugins/tpm "$DEST"
fi
