# dotfiles

Configs for my MacBook (macOS) and my PC (Omarchy). The old Arch Linux setup lives on the [`arch-mar-2025`](https://github.com/IsmaeelAkram/dotfiles/tree/arch-mar-2025) branch.

| Config | Linked to | Platform |
| --- | --- | --- |
| `zshrc`, `zprofile` | `~/.zshrc`, `~/.zprofile` | both |
| `nvim/` | `~/.config/nvim` | both |
| `tmux/` | `~/.config/tmux` | both |
| `ghostty/` | `~/.config/ghostty` | both |
| `omp/config.yml` | `~/.omp/agent/config.yml` | both |
| `pi/settings.json` | `~/.pi/agent/settings.json` | both |
| `omniwm/` | `~/.config/omniwm` | macOS |
| `skhd/` | `~/.config/skhd` | macOS |

## Install

```sh
git clone --recursive https://github.com/IsmaeelAkram/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` symlinks each config into place and moves anything already there to `~/.dotfiles-backup/<timestamp>/`; re-running it is safe. It also:

- copies OmniWM's LaunchAgents into `~/Library/LaunchAgents` (macOS)
- links the active Omarchy theme into Neovim so it follows theme switches (Omarchy)

Omarchy's default shell is bash; switch to zsh with `chsh -s "$(command -v zsh)"`.
