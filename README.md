# Shared Terminal Dotfiles

This directory is the single source of truth for the shared `kitty`, `tmux`,
and `nvim` configuration used by both macOS users on this machine.

## Layout

- `kitty/`
- `tmux/`
- `nvim/`

The `tmux/plugins/` directory is intentionally ignored by Git. TPM can manage
those plugin clones inside the shared directory without polluting version
control.

## Current behavior

Both users should point these paths at this repo:

- `~/.config/kitty`
- `~/.config/tmux`
- `~/.config/nvim`

That means config changes are not "synced" by pulling. They are the same files,
so a change from either user is immediately visible to the other user.

## Bootstrap another user

Run this once from the target account:

```bash
/Users/Shared/dotfiles/bootstrap-user.sh
```

The script backs up any existing config directories to
`*.pre-shared-<timestamp>` and then replaces them with symlinks.

## Git usage

```bash
git -C /Users/Shared/dotfiles status
git -C /Users/Shared/dotfiles add .
git -C /Users/Shared/dotfiles commit -m "Update terminal config"
```

## Reloading

- `kitty`: `ctrl+shift+f5` or `kill -SIGUSR1 $KITTY_PID`
- `tmux`: `tmux source-file ~/.config/tmux/tmux.conf`
- `nvim`: restart Neovim
