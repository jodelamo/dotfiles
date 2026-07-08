#!/bin/sh

# Resolve the repository root based on this script's location
repo_root="$(cd "$(dirname -- "$0")" && pwd)"

ini_file="$repo_root/config.ini"
section="links"

# Run OS-specific setup
case "$(uname)" in
  Darwin)
    "$repo_root/bin/macos"
    ;;
  Linux)
    "$repo_root/bin/linux"
    ;;
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
  abs_source="$repo_root/$source"
  abs_dest="$HOME/$dest"

  if [ -e "$abs_source" ]; then
    install -d "$(dirname "$abs_dest")"
    ln -sfn "$abs_source" "$abs_dest"
    echo "Linked: $abs_source -> $abs_dest"
  else
    echo "Warning: Source does not exist: $abs_source"
  fi
done
