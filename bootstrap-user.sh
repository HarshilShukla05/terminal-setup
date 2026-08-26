#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
timestamp="$(date +%Y%m%d-%H%M%S)"

mkdir -p "$config_home"

for name in kitty tmux nvim; do
  source_path="$repo_root/$name"
  target_path="$config_home/$name"

  if [ -L "$target_path" ]; then
    current_target="$(readlink "$target_path")"
    if [ "$current_target" = "$source_path" ]; then
      echo "$target_path already points to $source_path"
      continue
    fi
    mv "$target_path" "${target_path}.pre-shared-${timestamp}"
  elif [ -e "$target_path" ]; then
    mv "$target_path" "${target_path}.pre-shared-${timestamp}"
  fi

  ln -s "$source_path" "$target_path"
  echo "linked $target_path -> $source_path"
done

# ─── Scripts on PATH (tmux-sessionizer, …) ──────────────────
# Symlink repo bin/* into ~/.local/bin so tmux prefix+f and nvim <C-f> resolve
# to the shared script for both users (each user still has their own
# ~/.config/tmux-sessionizer/paths to customize project roots).
local_bin="$HOME/.local/bin"
mkdir -p "$local_bin"
if [ -d "$repo_root/bin" ]; then
  for script in "$repo_root"/bin/*; do
    [ -e "$script" ] || continue
    name="$(basename "$script")"
    target="$local_bin/$name"
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$script" ]; then
      echo "$target already points to $script"
      continue
    elif [ -e "$target" ]; then
      mv "$target" "${target}.pre-shared-${timestamp}"
    fi
    ln -s "$script" "$target"
    echo "linked $target -> $script"
  done
fi

# ─── tmux plugins ───────────────────────────────────────────
# tmux/plugins/ is gitignored, so a fresh clone has no TPM and tmux.conf's
# `run '~/.config/tmux/plugins/tpm/tpm'` would be a no-op. Clone every plugin
# declared in tmux.conf (TPM itself included) straight into the repo.
#
# Deliberately NOT using TPM's bin/install_plugins: it resolves its target
# directory from an already-running tmux server, so on a machine where tmux is
# up with another config it installs into the wrong checkout.
plugins_dir="$repo_root/tmux/plugins"
mkdir -p "$plugins_dir"
while IFS= read -r spec; do
  [ -n "$spec" ] || continue
  dest="$plugins_dir/${spec##*/}"
  if [ -d "$dest" ]; then
    echo "plugin ${spec##*/} already present"
  else
    echo "cloning $spec"
    git clone --quiet --depth 1 "https://github.com/$spec" "$dest" ||
      echo "NOTE: could not clone $spec — run prefix+I inside tmux to retry."
  fi
done <<PLUGINS
$(sed -nE "s/^[[:space:]]*set -g @plugin '([^']+)'.*/\1/p" "$repo_root/tmux/tmux.conf")
PLUGINS

# Warn if ~/.local/bin isn't on PATH (most macOS shells include it by default).
case ":${PATH:-}:" in
  *":$local_bin:"*) ;;
  *) echo "NOTE: add \"$local_bin\" to your PATH (e.g. in ~/.zshrc) so tmux-sessionizer is found." ;;
esac
