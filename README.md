# Neovim Configuration

This repository contains my personal Neovim configuration. 

## Structure

The configuration is organized as follows:

- `after/queries/`: Tree-sitter queries for different languages.
- `init.lua`: The main configuration file for Neovim.
- `lua/plugins`: Plugins with their configuration
- `lua/opt.lua`: neovim options.
- `lua/autocmd.lua`: Autocommands.
- `lua/usercmd.lua`: Custom commands.
- `lua/keymaps.lua`: General keymaps.

## Installation

To install this configuration, clone this repository into your Neovim configuration directory and then run Neovim. The `init.lua` script will automatically clone and set up the necessary plugins.

```sh
git clone https://github.com/MrEhbr/nvim-config.git ~/.config/nvim
```
