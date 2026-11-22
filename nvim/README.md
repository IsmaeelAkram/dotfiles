# My Neovim configuration based off LazyVim
I'm switching from regular Vim to Neovim for use on Fedora Linux and MacOS.
A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Omarchy
On Omarchy, link the active system theme so Neovim follows theme switches (falls back to nordic elsewhere):

```sh
ln -snf ../../../../.local/state/omarchy/current/theme/neovim.lua ~/.config/nvim/lua/plugins/theme.lua
```
