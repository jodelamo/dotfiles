# Dotfiles

This repository manages dotfiles using symlinks and per-tool installers.

## Structure

Each tool or program gets its own directory at the repo root (e.g. `go/`, `node/`, `ollama/`). A directory may contain:

- Configuration files to be symlinked into `$HOME`
- An `install.sh` script for installation and setup

## Symlinks

When adding new configuration files or directories, add the corresponding symlink entry to `config.ini`. The format is:

```
[links]
<target relative to $HOME> = <source relative to repo root>
```

All symlinks should be registered in `config.ini` so they can be managed consistently.

`bootstrap.sh` parses `config.ini` and creates the symlinks.

## Installers

To add installation logic for a tool, create an `install.sh` in its directory:

```
<tool>/install.sh
```

The top-level `install.sh` automatically discovers and runs every `<dir>/install.sh` found in subdirectories. No registration step is needed -- just adding the file is sufficient.

Installer scripts should be idempotent (safe to re-run). Common patterns used in existing installers:

- Pin a version at the top of the script
- Check if already installed before installing (`command -v`)
- Install global packages in a loop

## Bootstrapping

Run `bootstrap.sh` to apply everything:

1. OS-specific setup (`bin/macos` or `bin/linux`)
2. Symlinks from `config.ini`

Run `install.sh` separately to execute all per-tool installers.

## Commits

Use [Conventional Commits](https://www.conventionalcommits.org/) for all commit messages. The format is:

```
<type>(<scope>): <description>
```

Common types: `feat`, `fix`, `docs`, `chore`, `refactor`, `style`, `test`. The scope should typically be the tool directory name (e.g. `go`, `zsh`, `node`).
