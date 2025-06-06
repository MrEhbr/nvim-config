local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "
g.loaded_ruby_provider = 0
g.omni_sql_no_default_maps = 1

-- Set highlight on search
opt.hlsearch = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = "unnamedplus"

opt.relativenumber = true
vim.opt_local.conceallevel = 2
vim.filetype.add({ extension = { templ = "templ", bru = "bruno", tmpl = "gotmpl" } })

opt.showmode = false

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.scrolloff = 10

opt.ignorecase = true
opt.smartcase = true

-- Numbers
opt.number = true
opt.numberwidth = 2

opt.timeoutlen = 400
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")
-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- Folding
vim.o.fillchars = [[eob: ,fold: ,foldopen: ,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Floating border
vim.o.winborder = "rounded"
