# Dotfiles

This repository manages dotfiles using symlinks defined in `config.ini`.

## Symlinks

When adding new configuration files or directories, add the corresponding symlink entry to `config.ini`. The format is:

```
[links]
<target relative to $HOME> = <source relative to repo root>
```

All symlinks should be registered in `config.ini` so they can be managed consistently.

After updating `config.ini`, run `bootstrap.sh` to apply the symlinks.
