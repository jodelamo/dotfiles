# dotfiles

> My dotfiles

Not really intended for use by anyone else.

## Usage

Clone the repository:

```zsh
git clone git@github.com:jodelamo/dotfiles.git ~/.dotfiles
```

In a `zsh` shell, symlink and run installation scripts:

```zsh
./bootstrap.sh
./install.sh
```

To manually stow a specific package:

```zsh
cd ~/.dotfiles/stow-packages
stow -t ~ package-name
```

To unstow a package:

```zsh
cd ~/.dotfiles/stow-packages  
stow -t ~ -D package-name
```
