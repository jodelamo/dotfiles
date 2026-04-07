#!/bin/sh

version="3.12.4"

case "$(uname)" in
  Darwin)
    CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install "$version" --skip-existing
    ;;
  Linux)
    sudo apt install -y build-essential libssl-dev libffi-dev libbz2-dev \
      libreadline-dev libsqlite3-dev zlib1g-dev libncurses-dev liblzma-dev tk-dev
    pyenv install "$version" --skip-existing
    ;;
esac

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
