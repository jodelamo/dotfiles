#!/bin/sh

ini_file="config.ini"
section="links"

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ "$(uname)" = "Darwin" ]; then
  ./bin/macos
elif [ "$(uname)" = "Linux" ]; then
  ./bin/linux
fi

# Parse the INI file to figure out what needs to be linked
awk -F '=' -v section="$section" '
  $0 ~ /^\[/ { in_section = ($0 == "[" section "]") }
  in_section && $1 !~ /^\[/ && $1 !~ /^$/ { 
    gsub(/^[ \t]+|[ \t]+$/, "", $1)
    gsub(/^[ \t]+|[ \t]+$/, "", $2)
    print $1, $2
  }
' "$ini_file" | while read -r dest source; do
  if [ -e "$source" ]; then
    absolute_source="$HOME/.dotfiles/$source"
    absolute_dest="$HOME/$dest"

    if [ -e "$absolute_source" ]; then
      install -d "$(dirname "$absolute_dest")"
      ln -sfn "$absolute_source" "$absolute_dest"
      echo "🔗 Linked: $absolute_source -> $absolute_dest"
    else
      echo "⚠️  Warning: Source does not exist: $absolute_source"
    fi
  fi
done
