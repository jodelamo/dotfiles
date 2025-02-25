#!/bin/sh

version="3.12.4"

CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install "$version" --skip-existing
pyenv global "$version"
pyenv rehash

pip install --upgrade pip

installed=$(pip list | awk 'FNR > 2 { print $1 }')

packages="neovim pynvim"

for p in $packages; do
  if ! echo "$installed" | grep -q "^$p$"; then
    pip install --user "$p"
  fi
done
