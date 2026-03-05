# Copilot Instructions

## Architecture

This is a macOS-focused dotfiles repository using a **topic-based organization**: each top-level directory (e.g., `git/`, `zsh/`, `nvim/`) is a self-contained topic that can contribute shell configuration, aliases, and installers.

### Shell loading order

The zsh entrypoint is `zsh/zshrc`, which sources all `*.zsh` files from every topic directory in a specific order:

1. `**/path.zsh` — PATH modifications (loaded first)
2. All other `**/*.zsh` files — aliases, env vars, functions, config (excluding path and completion)
3. `**/completion.zsh` — completion scripts (loaded last, after `compinit`)

Secrets live in `~/.localrc` (sourced at the top of zshrc, never committed).

### Symlinks via config.ini

`bootstrap.sh` reads `config.ini` under the `[links]` section to create symlinks from `~/.dotfiles/<source>` to `~/<destination>`. When adding a new config file that should be symlinked, add an entry to `config.ini` rather than creating symlinks manually.

### Per-topic installers

`install.sh` at the root iterates all subdirectories and runs any `<topic>/install.sh` it finds. To add installation steps for a new tool, create an `install.sh` inside its topic directory.

### macOS bootstrap

`bootstrap.sh` runs `bin/macos`, which installs Homebrew packages from `homebrew/Brewfile` and applies macOS defaults from `macos/set-defaults.sh`.

## Conventions

### Adding a new topic

Create a new top-level directory. Inside it, use these conventional filenames:

- `aliases.zsh` — shell aliases
- `path.zsh` — PATH additions
- `completion.zsh` — zsh completions
- `env.zsh` — environment variables
- `install.sh` — one-time setup script
- `config.zsh` — other zsh configuration

These are auto-sourced by zshrc based on file suffix and name; no manual registration needed.

### Shell scripts

- Use `#!/bin/sh` for install scripts and `bin/` executables (POSIX-compatible)
- zsh-specific features are only used in `*.zsh` files
- The `functions/` directory holds autoloaded zsh functions (one function per file, filename = function name)

### Git

- Commit messages are linted with [commitlint](https://commitlint.js.org/) via CI (conventional commits)
- Default branch is `main`

## CI

The only CI workflow is **commit linting** (`.github/workflows/static-tests.yml`), which runs `commitlint` on push. There are no build or test commands.
