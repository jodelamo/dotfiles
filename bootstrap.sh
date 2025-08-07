#!/bin/sh

ini_file="config.ini"
section="links"

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Run OS-specific setup
case "$(uname)" in
  Darwin) ./bin/macos ;;
  Linux)  ./bin/linux ;;
esac

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
    abs_source="$HOME/.dotfiles/$source"
    abs_dest="$HOME/$dest"

    if [ -e "$abs_source" ]; then
      install -d "$(dirname "$abs_dest")"
      ln -sfn "$abs_source" "$abs_dest"
      echo "🔗 Linked: $abs_source -> $abs_dest"
    else
      echo "⚠️  Warning: Source does not exist: $abs_source"
    fi
  fi
done
