#!/bin/sh

version="22.13.1"

nodenv install "$version" --skip-existing
nodenv global "$version"
nodenv rehash

installed=$(npm ls -g -p --depth=0 | sed '1d' | sed 's@.*/@@')

packages="neovim"

for p in $packages; do
  echo "$installed" | grep -qx "$p" || npm install -g "$p"
done
