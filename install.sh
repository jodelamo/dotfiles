#!/bin/sh

for dir in */ ; do
  # Check if "install.sh" exists in the subdirectory
  if [ -f "$dir/install.sh" ]; then
    echo "📦 Running installer: $(basename $dir)"
    # Execute the install script
    (cd "$dir" && sh install.sh)
  fi
done
