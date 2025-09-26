#!/bin/sh

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Run OS-specific setup
case "$(uname)" in
  Darwin) ./bin/macos ;;
esac

# Install GNU Stow if not already installed
if ! command -v stow &> /dev/null; then
  echo "Installing GNU Stow..."
  brew install stow
fi

# Use GNU Stow to symlink dotfiles
cd "$HOME/.dotfiles/stow-packages" || exit 1

echo "🔗 Stowing dotfiles..."
for package in */; do
  package_name=$(basename "$package")
  echo "  📦 Stowing $package_name"
  stow -t "$HOME" "$package_name"
done

echo "✅ Dotfiles stowed successfully!"
