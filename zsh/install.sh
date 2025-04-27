#!/bin/sh

# Install antidote, zsh plugin manager
# Ref: https://github.com/mattmc3/antidote?tab=readme-ov-file#install-with-git 
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote
