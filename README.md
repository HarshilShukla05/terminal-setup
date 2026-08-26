# terminal-setup

My terminal environment: **kitty + tmux + nvim** (LazyVim base, kanagawa-dragon
theme), plus a few helper scripts. Clone it on any machine and run one script.

## Quick start

```bash
git clone https://github.com/HarshilShukla05/terminal-setup.git ~/.dotfiles
~/.dotfiles/bootstrap-user.sh
```

That script is idempotent — safe to re-run any time. It:

1. Symlinks `~/.config/{kitty,tmux,nvim}` at this repo (backing up anything
   already there to `*.pre-shared-<timestamp>`).
2. Symlinks `bin/*` into `~/.local/bin` so `tmux-sessionizer` and friends
   resolve on PATH.
3. Clones TPM and installs the tmux plugins.

Then open Neovim once — lazy.nvim bootstraps itself and installs plugins from
the pinned `nvim/lazy-lock.json`.

The clone location doesn't matter; every path is derived from the repo root.

## Layout

| Path | What |
| --- | --- |
| `kitty/` | terminal config + kanagawa theme |
| `tmux/` | `tmux.conf`, TPM plugin list, status bar |
| `nvim/` | LazyVim config, Prime-style keymaps, pinned plugin lockfile |
| `bin/` | `tmux-sessionizer`, `tmux-claude`, `tmux-branch`, `cb` |

Not tracked (installed on demand): `tmux/plugins/`, `tmux/resurrect/`, and
nvim's plugin data under `~/.local/share/nvim`.

## Per-machine bits

Project roots for `tmux-sessionizer` (prefix+f) are **not** in this repo — each
machine lists its own in `~/.config/tmux-sessionizer/paths`, one per line:

```
~/projects
~/work
```

Without that file it falls back to `~/projects`, `~/Developer`, `~/work`.

## Requirements

`git`, `tmux` >= 3.2, `nvim` >= 0.9, and optionally `kitty`. `fzf` and
`ripgrep` are expected by the sessionizer and telescope.

## Reloading

- kitty: `ctrl+shift+f5`
- tmux: prefix+r
- nvim: restart

## Two accounts on one Mac

Both macOS users can share a single clone (e.g. in `/Users/Shared/dotfiles`) by
running `bootstrap-user.sh` from each account — the symlinks point at the same
files, so a change from either account is live for both immediately. Keep the
tree group-writable + setgid so both can commit.
