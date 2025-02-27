#!/bin/sh

ini_file="config.ini"
section="links"

if [ "$(uname)" = "Darwin" ]; then
  ./bin/macos
fi

awk -F '=' -v section="$section" '
  $0 ~ /^\[/ { in_section = ($0 == "[" section "]") }
  in_section && $1 !~ /^\[/ && $1 !~ /^$/ { 
    gsub(/^[ \t]+|[ \t]+$/, "", $1);
    gsub(/^[ \t]+|[ \t]+$/, "", $2);
    print $1, $2;
  }
' "$ini_file" | while read -r dest source; do
  if [ -e "$source" ]; then
    # Ensure the destination directory exists
    dest_dir=$(dirname "$dest")
    mkdir -p "$dest_dir"

    # Create symlink
    echo "🔗 Create symlink: $source -> $dest"
    ln -sfn "$source" "$dest"
  else
    echo "Warning! Source does not exist: $source"
  fi
done
