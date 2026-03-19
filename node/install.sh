#!/bin/sh

version="24.14.0"

nodenv install "$version" --skip-existing
nodenv global "$version"
nodenv rehash

installed=$(npm ls -g -p --depth=0 | sed '1d' | sed 's@.*/@@')

packages="neovim mcp-hub@latest"

for p in $packages; do
  echo "$installed" | grep -qx "$p" || npm install -g "$p"
done
