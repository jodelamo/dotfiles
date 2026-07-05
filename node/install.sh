#!/bin/sh

if ! command -v nodenv > /dev/null 2>&1; then
  git clone https://github.com/nodenv/nodenv.git ~/.nodenv
  git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi

version="24.16.0"

nodenv install "$version" --skip-existing
nodenv global "$version"
nodenv rehash

installed=$(npm ls -g -p --depth=0 | sed '1d' | sed 's@.*/@@')

packages="neovim mcp-hub@latest"

for p in $packages; do
  echo "$installed" | grep -qx "$p" || npm install -g "$p"
done
