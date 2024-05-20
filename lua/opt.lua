local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "
g.loaded_ruby_provider = 0
g.omni_sql_no_default_maps = 1
g.autoformat = true

opt.hlsearch = true
opt.clipboard = "unnamedplus"

opt.relativenumber = true
opt.conceallevel = 2
vim.filetype.add({ extension = { templ = "templ", bru = "bruno", tmpl = "gotmpl" } })

opt.showmode = false

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.scrolloff = 10

opt.ignorecase = true
opt.smartcase = true

opt.number = true
opt.numberwidth = 2

opt.timeoutlen = 400
opt.updatetime = 250

opt.whichwrap:append("<>[]hl")
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- Folding
vim.o.fillchars = [[eob: ,fold: ,foldopen: ,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.winborder = "rounded"

opt.undofile = true
opt.undolevels = 10000

opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

opt.signcolumn = "yes"
opt.inccommand = "split"

opt.cursorline = true
opt.virtualedit = "block"

opt.smoothscroll = true
opt.sidescrolloff = 8
opt.jumpoptions = "view"

opt.confirm = true
