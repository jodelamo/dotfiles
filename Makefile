.PHONY: bundle install stow

install: /opt/homebrew/bin/brew bundle

bundle:
	brew bundle

/opt/homebrew/bin/brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

stow:
	stow --no --verbose --target=$$HOME --restow */
