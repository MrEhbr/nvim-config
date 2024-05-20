vim.loader.enable()

-- Disable built-in ftplugin treesitter for lua (fixes nightly query mismatch)
vim.g.ts_highlight_lua = false

require("opt")
require("core.lazy")
require("core.lsp")
require("keymaps")
require("autocmd")
require("usercmd")
