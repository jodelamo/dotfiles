# Stow Package Structure

This dotfiles repository now uses GNU Stow for managing symbolic links. Each subdirectory in `stow-packages/` represents a "package" that can be independently managed.

## Package Overview

- **git** - Git configuration (.gitconfig, .gitignore)
- **kitty** - Kitty terminal emulator configuration
- **mcphub** - MCPHub server configuration
- **nvim** - Neovim configuration and plugins
- **ripgrep** - Ripgrep configuration (.ripgreprc)
- **ruby** - Ruby/Gem configuration (.gemrc)
- **tmux** - tmux configuration (.tmux.conf)  
- **zellij** - Zellij terminal multiplexer configuration
- **zsh-config** - Zsh configuration files (.zshrc, plugins)
- **zsh-env** - Zsh environment configuration (.zshenv)

## Package Structure

Each package follows the Stow convention where the directory structure within the package mirrors the target directory structure in the home directory.

For example:
```
stow-packages/kitty/
└── .config/
    └── kitty/
        ├── current-theme.conf
        └── kitty.conf
```

When stowed, creates:
```
~/.config/kitty/current-theme.conf -> ~/.dotfiles/stow-packages/kitty/.config/kitty/current-theme.conf
~/.config/kitty/kitty.conf -> ~/.dotfiles/stow-packages/kitty/.config/kitty/kitty.conf
```

## Managing Packages

From `~/.dotfiles/stow-packages/`:

```bash
# Stow a single package
stow -t ~ package-name

# Unstow a package (remove symlinks)
stow -t ~ -D package-name

# Restow a package (unstow then stow)  
stow -t ~ -R package-name

# Stow all packages
for package in */; do stow -t ~ "$(basename "$package")"; done
```

## Migration from config.ini

The old `config.ini` system has been replaced with this Stow-based approach. Original configuration files remain in their respective directories (git/, kitty/, etc.) for reference and are copied into the appropriate Stow package structure.