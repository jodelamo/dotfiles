#!/bin/sh

version="3.4.1"

rbenv install "$version" --skip-existing
rbenv global "$version"
rbenv rehash

installed=$(gem list | awk '{ print $1 }')

gems="bundler neovim rubocop"

for g in $gems; do
  echo "$installed" | grep -qx "$g" || gem install "$g"
done

