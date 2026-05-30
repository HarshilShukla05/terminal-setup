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

# Warn if ~/.local/bin isn't on PATH (most macOS shells include it by default).
case ":${PATH:-}:" in
  *":$local_bin:"*) ;;
  *) echo "NOTE: add \"$local_bin\" to your PATH (e.g. in ~/.zshrc) so tmux-sessionizer is found." ;;
esac
