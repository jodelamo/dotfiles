#!/bin/sh

brewfile="$(dirname $0)/Brewfile"

if [ ! command -v brew >/dev/null 2>&1 ]; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle --file=$brewfile
