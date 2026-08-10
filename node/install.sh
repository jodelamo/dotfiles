#!/bin/sh

if ! command -v nodenv > /dev/null 2>&1; then
  curl -fsSL https://github.com/nodenv/nodenv-installer/raw/HEAD/bin/nodenv-installer | bash
  $HOME/.nodenv/bin/nodenv init
fi

version="24.18.0"

nodenv install "$version" --skip-existing
nodenv global "$version"
nodenv rehash

installed=$(npm ls -g -p --depth=0 | sed '1d' | sed 's@.*/@@')

packages="neovim mcp-hub@latest"

for p in $packages; do
  echo "$installed" | grep -qx "$p" || npm install -g "$p"
done
