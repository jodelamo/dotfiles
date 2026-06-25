#!/bin/sh

# Install antidote, zsh plugin manager
# Ref: https://github.com/mattmc3/antidote?tab=readme-ov-file#install-with-git
antidote_dir="${ZDOTDIR:-$HOME}/.antidote"

if [ ! -d "$antidote_dir" ]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$antidote_dir"
fi
