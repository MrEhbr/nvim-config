# Neovim Configuration

My personal Neovim configuration. 56 plugins managed with
[lazy.nvim](https://github.com/folke/lazy.nvim), starting in roughly 50 ms.

See [CHEATSHEET.md](CHEATSHEET.md) for the full keymap reference.

## Requirements

**Neovim 0.12 or newer**, developed against 0.13 nightly. `lua/core/lsp/init.lua`
calls `vim.lsp.inline_completion.enable()`, which was added in 0.12, so 0.11 fails
at startup. Also uses `vim.lsp.config`/`vim.lsp.enable`, `vim.hl.priorities` and
`vim.fs.relpath`.

Required:

- `git`
- `ripgrep` — the Snacks picker and grep actions shell out to `rg`
- A C compiler and `make` — Tree-sitter parsers are compiled on demand

Optional, per feature:

- `gh` — GitHub integration (octo.nvim)
- `direnv` — per-project environments (direnv.nvim)
- `tmux` — seamless split navigation (vim-tmux-navigator)
- `cargo` — `:LspCargoFeatures` completion reads `cargo metadata`

## Structure

```text
init.lua              entry point; requires the modules below in order
lua/
  opt.lua             options, filetypes, provider and PATH setup
  keymaps.lua         general keymaps
  autocmd.lua         autocommands, including LSP progress notifications
  usercmd.lua         user commands
  core/
    lazy.lua          lazy.nvim bootstrap and setup
    lsp/
      init.lua        vim.lsp.enable list, diagnostics, LspAttach keymaps
      servers.lua     per-server settings
      rust_analyzer.lua  rust-analyzer settings and :LspCargo* commands
  config/             non-plugin-spec helpers required by plugin specs
    lsp.lua           capabilities
    snacks.lua        custom picker actions
    utils.lua         file path and git URL helpers
    dbee.lua          nvim-dbee tab layout
  plugins/            one file per plugin or related group (27 files)
after/queries/        Tree-sitter query overrides (go, rust, php, bruno)
flake.nix             Nix devshell for working on this config (stylua, lua_ls)
```

## Installation

```sh
git clone https://github.com/MrEhbr/nvim-config.git ~/.config/nvim
nvim
```

lazy.nvim bootstraps itself on first launch and installs everything. Tree-sitter
parsers are installed on demand the first time you open a matching filetype.

Then provision external tooling:

```vim
:MasonInstallAll
```

That command is defined in `lua/plugins/mason.lua` and installs everything in its
`ensure_installed` list. Mason does not do this automatically, so re-run it after
changing the list.

## Language servers

Servers are enabled in `lua/core/lsp/init.lua` via `vim.lsp.enable`, with
per-server settings in `lua/core/lsp/servers.lua`. Defaults come from
nvim-lspconfig; only the deltas live here.

`gopls` and `rust-analyzer` are **not** managed by Mason — they are expected on
`PATH` from the Go and Rust toolchains. Note that `lua/opt.lua` prepends Mason's
`bin` directory to `PATH`, so a Mason-installed copy of a tool will shadow one
provided by a project environment.

## Notable behaviour

- **Deleting does not clobber the register.** cutlass maps `d`/`c` to the black
  hole; `x` is the cut operation. See the cheatsheet.
- **Format on save** is on by default, toggled with `<leader>uf`. PHP formats
  after save; everything else before. Formatting falls back to the LSP when a
  formatter binary is missing — `:ConformInfo` shows what actually ran.
- **Folds** are rendered by `snacks.statuscolumn`, so `foldcolumn` is off.
