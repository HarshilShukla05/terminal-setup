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
