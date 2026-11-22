#!/usr/bin/env bash
# Links these dotfiles into place on macOS and Omarchy:
#   git clone --recursive https://github.com/IsmaeelAkram/dotfiles ~/dotfiles && ~/dotfiles/install.sh
# Safe to re-run: links already pointing here are left alone, and anything else in the way
# (e.g. Omarchy's stock nvim/tmux/ghostty configs) is moved to ~/.dotfiles-backup/<timestamp>/.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link() {
  local src=$1 dst=$2
  if [[ -L $dst && $(readlink "$dst") == "$src" ]]; then
    return
  fi
  if [[ -e $dst || -L $dst ]]; then
    local saved="$BACKUP/${dst#"$HOME"/}"
    mkdir -p "$(dirname "$saved")"
    mv "$dst" "$saved"
    echo "backed up $dst -> $saved"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "linked $dst -> $src"
}

# Copied rather than symlinked: launchd does not reliably load symlinked plists at login.
agent() {
  local src=$1 dst="$HOME/Library/LaunchAgents/${1##*/}"
  if cmp -s "$src" "$dst"; then
    return
  fi
  mkdir -p "$(dirname "$dst")"
  launchctl bootout "gui/$(id -u)" "$dst" 2>/dev/null || true
  cp "$src" "$dst"
  launchctl bootstrap "gui/$(id -u)" "$dst"
  echo "loaded $dst"
}

# tmux plugins are submodules.
git -C "$DOTFILES" submodule update --init --recursive

link "$DOTFILES/zshrc" "$HOME/.zshrc"
link "$DOTFILES/zprofile" "$HOME/.zprofile"
link "$DOTFILES/nvim" "$HOME/.config/nvim"
link "$DOTFILES/tmux" "$HOME/.config/tmux"
link "$DOTFILES/ghostty" "$HOME/.config/ghostty"

if [[ $(uname -s) == Darwin ]]; then
  link "$DOTFILES/omniwm" "$HOME/.config/omniwm"
  link "$DOTFILES/skhd" "$HOME/.config/skhd"
  for plist in "$DOTFILES"/omniwm/launchagents/*.plist; do
    agent "$plist"
  done
fi

# Omarchy: Neovim follows the system theme through this link (ignored by nvim/.gitignore).
omarchy_theme="$HOME/.local/state/omarchy/current/theme/neovim.lua"
if [[ -d $(dirname "$omarchy_theme") ]]; then
  link "$omarchy_theme" "$DOTFILES/nvim/lua/plugins/theme.lua"
fi
