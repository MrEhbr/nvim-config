# Neovim Configuration Cheatsheet

## Quick Reference

**Leader Key**: `Space`

---

## File Navigation (Snacks.nvim)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Grep search |
| `<leader>fo` | Recent files |
| `<C-n>` | Toggle file explorer |
| `<leader>fc` | Search in current buffer |

---

## Buffer Management

| Key | Action |
|-----|--------|
| `<tab>` / `<S-tab>` | Next/previous buffer |
| `<leader><tab>` | Pick buffer (visual) |
| `<leader>x` | Close buffer |
| `<leader>X` | Close all other buffers |

---

## Harpoon (Quick Marks)

| Key | Action |
|-----|--------|
| `<leader>ma` | Add current file to marks |
| `<leader>ml` | List all marks |
| `<leader>1-5` | Jump to mark 1-5 |
| `<leader>mj/mk` | Next/prev mark |
| `<leader>mc` | Clear all marks |
| `<leader>md` | Delete current mark |

---

## LSP (15 languages supported)

| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `gs` | Signature help |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `gy` | Go to type definition |
| `<leader>ca` | Code actions |
| `<leader>lr` | Rename symbol |
| `<leader>lh` | Toggle inlay hints |
| `<leader>la` | Run codelens |
| `<leader>fm` | Format file |
| `<leader>ld` | Document symbols |
| `<leader>lw` | Workspace symbols |

**Supported Languages**: Go, Rust, Lua, PHP, TypeScript/JS, JSON, YAML, Markdown, Nix, Dart, Java, Tailwind CSS, Templ, Biome

---

## Git Integration

| Key | Action |
|-----|--------|
| `]c` / `[c` | Next/prev hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hu` | Undo stage |
| `<leader>hR` | Reset buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>tb` | Toggle line blame |
| `<leader>gs` | Git status picker |
| `<leader>gl` | Git log |
| `<leader>gL` | Git log (current line) |
| `<leader>gb` | Git branches |
| `<leader>gd` | Git diff hunks |
| `<leader>gf` | Git file log |
| `<leader>hd` | Open diffview |
| `<leader>hf` | File history |
| `<leader>hD` | Staged diffs |
| `<leader>hx` | Close diffview |

---

## Debugging (DAP)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Continue/start debug |
| `<leader>dC` | Run to cursor |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dj/dk` | Stack down/up |
| `<leader>dl` | Run last |
| `<leader>dp` | Pause |
| `<leader>dr` | Toggle REPL |
| `<leader>dR` | Clear breakpoints |
| `<leader>ds` | Current session |
| `<leader>dt` | Terminate session |
| `<leader>dh` | Hover variable |
| `<leader>du` | Toggle DAP UI |

**Supports**: Go, Rust, PHP, JavaScript

---

## Testing (Neotest)

| Key | Action |
|-----|--------|
| `<leader>tn` | Run nearest test |
| `<leader>tf` | Run test file |
| `<leader>tA` | Run all tests |
| `<leader>tS` | Run test suite |
| `<leader>tl` | Run last test |
| `<leader>ta` | Attach to test |
| `<leader>ts` | Toggle summary |
| `<leader>to` | Show output |
| `<leader>tO` | Toggle output panel |
| `<leader>tt` | Stop test |
| `<leader>td` | Debug nearest test |
| `<leader>tD` | Debug test file |

---

## Text Manipulation (Mini.nvim)

| Key | Action |
|-----|--------|
| `ys{motion}{char}` | Add surround |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |
| `<leader>/` | Toggle comment |

**Examples**:
- `ysiw"` - Surround word with quotes
- `ds"` - Delete surrounding quotes
- `cs"'` - Change double quotes to single

---

## AI Assistant (Sidekick)

| Key | Action |
|-----|--------|
| `<M-a>` | Toggle Sidekick CLI |
| `<M-l>` | Apply next suggestion |
| `<M-.>` | Switch focus |
| `<leader>aa` | Select Sidekick CLI |
| `<leader>ap` | Ask prompt |
| `<leader>as` | Send selection (visual) |

---

## Toggle Options

| Key | Action |
|-----|--------|
| `<leader>uw` | Toggle word wrap |
| `<leader>ud` | Toggle diagnostics |
| `<leader>ul` | Toggle line numbers |
| `<leader>uL` | Toggle relative numbers |
| `<leader>uc` | Toggle conceallevel |
| `<leader>uT` | Toggle treesitter |
| `<leader>uf` | Toggle format-on-save |
| `<leader>uH` | Toggle inlay hints |
| `<leader>ug` | Toggle indent guides |
| `<leader>uD` | Toggle dim |

---

## Utilities

| Key | Action |
|-----|--------|
| `<leader>.` | Scratch buffer |
| `<leader>S` | Select scratch buffer |
| `<leader>fy` | Copy file path (interactive) |
| `<leader>ql` | Toggle quickfix |
| `<M-j>` / `<M-k>` | Next/prev quickfix item |
| `<leader>:` | Command history |
| `<leader>nh` | Notification history |
| `<leader>sk` | Search keymaps |
| `<leader>sq` | Quickfix picker |
| `<leader>uh` | Undo history |
| `<leader>qq` | Quit all |

---

## Window Navigation (tmux-aware)

| Key | Action |
|-----|--------|
| `<C-h>` | Window left |
| `<C-j>` | Window down |
| `<C-k>` | Window up |
| `<C-l>` | Window right |
| `<leader>-` | Horizontal split |
| `<leader>\|` | Vertical split |
| `<M-S-Up/Down>` | Resize height |
| `<M-S-Left/Right>` | Resize width |

---

## Code Folding (UFO)

| Key | Action |
|-----|--------|
| `zR` | Open all folds |
| `zr` | Open folds (except kinds) |
| `zM` | Close all folds |
| `zK` | Peek fold |

---

## Treesitter Textobjects (Code Navigation)

### Move Between Code Elements

| Key | Action |
|-----|--------|
| `]f` / `[f` | Next/prev function start |
| `]F` / `[F` | Next/prev function end |
| `]t` / `[t` | Next/prev class/type start |
| `]a` / `[a` | Next/prev parameter |

### Swap Parameters

| Key | Action |
|-----|--------|
| `<leader>sa` | Swap with next parameter |
| `<leader>sA` | Swap with previous parameter |

**Tip**: Works in visual and operator-pending modes too. Use `d]f` to delete to next function, `v]a` to select to next parameter.

---

## Flash.nvim (Quick Navigation)

Flash.nvim provides lightning-fast navigation with labeled jump targets.

### Keymaps

| Key | Mode | Action |
|-----|------|--------|
| `s` | n, x, o | Flash jump |
| `S` | n, x, o | Flash treesitter |
| `r` | o | Remote flash |
| `R` | o, x | Treesitter search |

### How It Works

**`s` - Flash Jump**
1. Press `s`
2. Type character(s) you want to jump to
3. Labels appear on all matches
4. Press the label key to jump instantly

**`S` - Flash Treesitter**
1. Press `S`
2. Labels appear on treesitter nodes (functions, blocks, etc.)
3. Press label to select/jump to that node
4. Great for selecting entire functions or code blocks

**`r` - Remote Flash (operator-pending)**
- Use with operators like `d`, `y`, `c`
- Example: `yr{label}` - yank text at remote location without moving cursor

**`R` - Treesitter Search (operator-pending/visual)**
- Combines search with treesitter node selection
- Example: `dR` then type pattern to delete matching treesitter node

### Examples

| Action | Keys | Result |
|--------|------|--------|
| Jump to "func" | `sfunc{label}` | Jump to any "func" match |
| Select function | `S{label}` | Select entire function node |
| Delete to word | `dsword{label}` | Delete from cursor to "word" |
| Yank remote line | `yr{label}` | Yank line at label without moving |
| Change block | `cS{label}` | Change entire treesitter block |

### Tips

1. **Fewer characters = more labels** - Type just enough to narrow down
2. **Treesitter mode** (`S`) is perfect for selecting code structures
3. **Remote flash** (`r`) lets you operate on distant text without losing position
4. **Works in visual mode** - Extend selection to any labeled target
5. **Operator-pending** - Combine with `d`, `y`, `c`, `v` for powerful edits

---

## General

| Key | Action |
|-----|--------|
| `<C-s>` | Save file |
| `<C-c>` | Copy whole file |
| `<C-d>` / `<C-u>` | Page down/up (centered) |
| `<Esc>` | Clear highlights |
| `;` | Enter command mode |
| `n` / `N` | Next/prev search (centered) |
| `J` | Join lines (cursor preserved) |

### Insert Mode

| Key | Action |
|-----|--------|
| `<C-b>` | Jump to line beginning |
| `<C-e>` | Jump to line end |

---

## Special Commands

| Command | Action |
|---------|--------|
| `:LspStatus` | Show LSP client info |
| `:LspCargoFeatures` | Set Rust cargo features |
| `:LspCargoFeaturesAll` | Enable all Rust features |
| `:LspCargoFeaturesList` | List current features |
| `:LspCargoReload` | Reload Rust workspace |

---

## Format-on-Save Languages

Formatters configured for: Go, Lua, Python, Shell, JavaScript/TypeScript, Markdown, Nix, PHP, SQL, Protobuf, Templ

---

## Tips for Better Usage

1. **Harpoon** (`<leader>ma`, `<leader>1-5`) - Mark frequently accessed files for instant jumping
2. **Snacks explorer** (`<C-n>`) - Shows git status inline with files
3. **Flash.nvim** - Enhances `f/t/F/T` with labels for fast character jumping
4. **Folding peek** (`zK`) - Preview fold contents without opening
5. **Quickfix workflow** - `<leader>ql` to toggle, `<M-j/k>` to navigate results
6. **Code coverage** - Available for Go via nvim-coverage plugin
7. **Database queries** - Use nvim-dbee with SQL completion
8. **Scratch buffers** (`<leader>.`) - Quick temporary editing space
9. **Which-key** - Press leader and wait to see available keymaps
10. **Format toggle** (`<leader>uf`) - Disable auto-format when needed

---

## Plugin Overview

| Category | Plugins |
|----------|---------|
| **UI** | kanagawa, lualine, bufferline, snacks.nvim |
| **Completion** | blink.cmp, friendly-snippets |
| **LSP** | nvim-lspconfig (built-in), lazydev |
| **Syntax** | nvim-treesitter, rainbow-delimiters |
| **Formatting** | conform.nvim |
| **Git** | gitsigns, diffview |
| **Testing** | neotest (go, rust, plenary adapters) |
| **Debugging** | nvim-dap, dap-ui |
| **Navigation** | harpoon, flash.nvim, oil.nvim |
| **Text** | mini.nvim (ai, surround, comment, pairs) |
| **AI** | sidekick.nvim |
| **Folding** | nvim-ufo |
| **Database** | nvim-dbee |
| **Markdown** | render-markdown.nvim |
