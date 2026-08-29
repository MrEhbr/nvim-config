# Neovim Configuration Cheatsheet

## Quick Reference

**Leader Key**: `Space`

---

## File Navigation

`<leader>ff` / `fg` / `fw` are served by **fff.nvim**; the rest by **Snacks.nvim**.

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files (fff) |
| `<leader>fg` | Grep search (fff) |
| `<leader>fw` | Grep word under cursor (fff, normal + visual) |
| `<leader>fo` | Recent files |
| `<leader>fr` | Resume last picker |
| `<C-n>` | Toggle file explorer |
| `-` | Open parent directory (oil.nvim) |
| `<leader>fc` | Search in current buffer |
| `<leader>sj` | Jumplist (filtered to cwd) |
| `<leader>sd` | Buffer diagnostics |
| `<leader>sD` | Workspace diagnostics |

---

## Inside Snacks Pickers

Once a picker is open, these keybindings are available. Most work in both insert (input) and normal (list) modes.

### Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<C-j>` / `<C-n>` | i, n | Move down in list |
| `<C-k>` / `<C-p>` | i, n | Move up in list |
| `<C-d>` / `<C-u>` | i, n | Scroll list down/up (half page) |
| `gg` / `G` | n | Jump to top/bottom of list |
| `zz` / `zt` / `zb` | n | Scroll list center/top/bottom |
| `<C-f>` / `<C-b>` | i, n | Scroll preview down/up |

### Opening Results

| Key | Mode | Action |
|-----|------|--------|
| `<CR>` | i, n | Confirm (open in current window) |
| `<S-CR>` | n | Pick window, then jump |
| `<C-s>` | i, n | Open in horizontal split |
| `<C-v>` | i, n | Open in vertical split |
| `<C-t>` | i, n | Open in new tab |

### Selection & Quickfix

| Key | Mode | Action |
|-----|------|--------|
| `<Tab>` / `<S-Tab>` | n | Select item and move next/prev |
| `<C-a>` | i, n | Select all items |
| `<C-q>` | i, n | Send selected (or all) to quickfix list |

### Toggling Features

| Key | Mode | Action |
|-----|------|--------|
| `<A-p>` | i, n | Toggle preview panel |
| `<A-u>` | n | Toggle maximized picker |
| `<A-h>` | n | Toggle hidden files |
| `<A-n>` | n | Toggle ignored files |
| `<A-o>` | n | Toggle follow symlinks |
| `<C-g>` | i, n | Toggle live grep (grep picker) |
| `<A-x>` | n | Inspect item (raw data) |
| `?` | n | Toggle help (shows all keybindings) |

### Focus & Layout

| Key | Mode | Action |
|-----|------|--------|
| `/` | n | Toggle focus between input and list |
| `i` | n | Focus input (enter insert mode) |
| `<A-w>` | i, n | Cycle focus: input → list → preview |
| `<C-w>H/J/K/L` | n | Move picker layout left/bottom/top/right |

### Insert Mode Registers

| Key | Action |
|-----|--------|
| `<C-r><C-w>` | Insert word under cursor |
| `<C-r><C-a>` | Insert WORD under cursor |
| `<C-r><C-l>` | Insert current line |
| `<C-r><C-f>` | Insert filename |
| `<C-r><C-p>` | Insert full file path |
| `<C-r>%` | Insert current filename |
| `<C-r>#` | Insert alternate filename |

### Closing

| Key | Mode | Action |
|-----|------|--------|
| `<Esc>` | n | Cancel and close picker |
| `q` | n | Cancel and close picker |

### Source-Specific Keys

**Undo History** (`<leader>uh`):

| Key | Action |
|-----|--------|
| `<C-y>` | Yank added changes from undo entry |
| `<C-d>` | Yank deleted changes from undo entry |

**File Explorer** (`<C-n>`):

| Key | Action |
|-----|--------|
| `y` | Copy file path |
| `f` | Grep in file's directory |
| `F` | Grep in file's directory (case-sensitive) |
| `D` | Diff two selected files |
| `v` / `s` | Open in vsplit / split |
| `{` / `}` | Jump to next/prev folder |
| `za` / `Z` | Close folder / close all folders |

### Tips

1. **`?` is your friend** — press `?` in normal mode inside any picker to see all available keybindings for that picker
2. **Multi-select workflow** — use `<Tab>` to select multiple items, then `<C-q>` to send them all to quickfix
3. **Live grep toggle** — in the grep picker, `<C-g>` switches between live grep and filtering existing results
4. **Hidden/ignored files** — toggle `<A-h>` and `<A-n>` to include files normally excluded from search
5. **Preview scrolling** — `<C-f>`/`<C-b>` scroll the preview without leaving the input field
6. **Quick inspect** — `<A-x>` in list mode opens an inspector showing the raw item data (useful for debugging)

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

## LSP

| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `<C-S-k>` | Signature help (also in insert mode) |
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
| `<leader>ll` | Trigger linting (nvim-lint) |
| `[d` / `]d` | Prev/next diagnostic |
| `[D` / `]D` | First/last diagnostic in buffer |
| `<C-w>d` | Show diagnostics under cursor |
| `<M-]>` / `<M-[>` | Next/prev inline completion (insert) |

> `<C-k>` is **window up**, not signature help. Signature help is `<C-S-k>`, which
> needs a terminal that distinguishes Ctrl+Shift (kitty keyboard protocol).

**Enabled servers**: gopls, rust_analyzer, lua_ls, intelephense, ts_ls, jsonls,
yamlls, marksman, nil_ls, dartls, jdtls, tailwindcss, templ, copilot

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
| `ih` | Git hunk textobject (operator/visual) |
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

## GitHub (Octo)

| Key | Action |
|-----|--------|
| `<leader>Op` | PR list |
| `<leader>OP` | PR create |
| `<leader>Os` | PR search |
| `<leader>Or` | Review start |
| `<leader>Oi` | Issue list |
| `<leader>OI` | Issue create |
| `<leader>OS` | Search |
| `<leader>OR` | Repo list |
| `<leader>On` | Notifications |
| `<leader>Oa` | Actions menu |

While reviewing a diff, `J` / `K` move between changed files.

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
| `<leader>dg` | Jump to line (no execution) |
| `<leader>dl` | Run last |
| `<leader>dp` | Pause |
| `<leader>dr` | Toggle REPL |
| `<leader>dR` | Clear breakpoints |
| `<leader>ds` | Current session |
| `<leader>dt` | Terminate session |
| `<leader>dh` | Hover variable |
| `<leader>du` | Toggle DAP UI |

**Supports**: Go (delve), Rust (codelldb), PHP (Xdebug)

> `js-debug-adapter` is installed by Mason but no JavaScript adapter or
> configuration is wired up in `lua/plugins/dap.lua`.

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

## Cut, Delete & Registers (cutlass)

Deleting does **not** clobber your yank register. `x` is the cut operation.

| Key | Action |
|-----|--------|
| `d` / `D` | Delete (to black hole — does not overwrite the register) |
| `c` / `C` | Change (to black hole) |
| `s` / `S` | Only in select mode; `s` is Flash in normal/visual |
| `x` | Cut (this is what fills the register) |
| `X` | Cut to end of line |
| `xx` | Cut line |
| `<Del>` | Delete without clobbering the register |
| `gp` | Paste from system clipboard |
| `p` (visual) | Paste over selection, keeping the original register |

---

## Text Manipulation (Mini.nvim)

### Surround (gs prefix)

| Key | Action |
|-----|--------|
| `gsa{motion}{char}` | Add surround |
| `gsd{char}` | Delete surround |
| `gsr{old}{new}` | Replace surround |
| `gsf{char}` | Find surround (right) |
| `gsF{char}` | Find surround (left) |
| `gsh{char}` | Highlight surround |

**Examples**:

- `gsaiw"` - Surround word with quotes
- `gsd"` - Delete surrounding quotes
- `gsr"'` - Replace double quotes with single

### Comment

| Key | Action |
|-----|--------|
| `<leader>/` | Toggle comment (mini.comment) |
| `gc{motion}` / `gcc` | Toggle comment (Neovim built-in) |

### Textobjects (mini.ai)

Enhanced `a` (around) and `i` (inside) textobjects with extra targets.

| Textobject | Description |
|------------|-------------|
| `q` | Quotes (any quote character) |
| `b` | Brackets (any bracket type) |
| `f` | Function call |
| `a` | Argument/parameter |
| `t` | HTML/XML tag |
| `o` | Block (code block) |
| `i` | Indentation scope |

**Modifiers** (prefix before textobject):

| Modifier | Description |
|----------|-------------|
| `n` | Next occurrence |
| `l` | Last (previous) occurrence |

**Examples**:

- `daf` - Delete around function call
- `ciq` - Change inside quotes (any type)
- `vib` - Select inside brackets
- `cin)` - Change inside next parentheses
- `dal"` - Delete around last double quote
- `yia` - Yank inside argument
- `vii` - Select inside indentation

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
| `<M-p>` | Toggle nvim-dbee (database UI) |
| `gx` | Open file path or URI under cursor |
| `g/` | Search inside visual selection |
| `:ShowkeysToggle` | Toggle on-screen keypress display |

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

## Bracket Navigation

From mini.basics unless noted.

| Key | Action |
|-----|--------|
| `[b` / `]b` | Prev/next buffer |
| `[q` / `]q` | Prev/next quickfix item |
| `[l` / `]l` | Prev/next location list item |
| `[t` / `]t` | Prev/next class/type start (treesitter) |
| `[f` / `]f` | Prev/next function start (treesitter) |
| `[F` / `]F` | Prev/next function end (treesitter) |
| `[a` / `]a` | Prev/next parameter (treesitter) |
| `[n` / `]n` | Select prev/next node (visual) |
| `[N` / `]N` | Select prev/next sibling node (visual) |
| `[` / `]` | Add empty line above/below |

Uppercase variants (`[B`, `]Q`, `[L`, …) jump to first/last.

---

## Code Folding (UFO)

| Key | Action |
|-----|--------|
| `zR` | Open all folds |
| `zr` | Open folds (except kinds) |
| `zM` | Close all folds |
| `zm` | Close folds by level |
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

Toggle with `<leader>uf`, or format on demand with `<leader>fm`. PHP formats
*after* save (Pint is slow); everything else formats before save.

> Formatting silently falls back to the LSP when a formatter binary is absent.
> Run `:MasonInstallAll` to provision the configured tools, and `:ConformInfo`
> to see what actually ran for the current buffer.

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
| **UI** | kanagawa, lualine, bufferline, snacks.nvim, tiny-inline-diagnostic, which-key |
| **Completion** | blink.cmp, friendly-snippets, lazydev |
| **LSP** | nvim-lspconfig, mason.nvim |
| **Syntax** | nvim-treesitter, treesitter-textobjects, nvim-colorizer |
| **Formatting** | conform.nvim |
| **Linting** | nvim-lint |
| **Git** | gitsigns, diffview, octo.nvim |
| **Testing** | neotest (golang, rust, plenary, vim-test), nvim-coverage |
| **Debugging** | nvim-dap, nvim-dap-view, dap-virtual-text, dap-disasm |
| **Navigation** | harpoon, flash.nvim, oil.nvim, fff.nvim, vim-tmux-navigator |
| **Text** | mini.nvim (basics, ai, surround, comment, pairs), cutlass |
| **AI** | sidekick.nvim |
| **Folding** | nvim-ufo |
| **Database** | nvim-dbee |
| **Markdown** | render-markdown.nvim |

Indent guides come from `snacks.indent` (toggle with `<leader>ug`).
