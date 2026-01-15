local g = vim.g
local o = vim.o

g.mapleader = " "
g.maplocalleader = " "
g.loaded_ruby_provider = 0
g.omni_sql_no_default_maps = 1
g.autoformat = true

o.breakindent = true
o.hlsearch = true
o.clipboard = "unnamedplus"

o.relativenumber = true
o.conceallevel = 2
vim.filetype.add({ extension = { templ = "templ", bru = "bruno", tmpl = "gotmpl" } })

o.showmode = false

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.scrolloff = 10

o.ignorecase = true
o.smartcase = true

o.number = true
o.numberwidth = 2

o.timeoutlen = 300
o.updatetime = 250

vim.opt.whichwrap:append("<>[]hl")
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	g["loaded_" .. provider .. "_provider"] = 0
end

local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- Folding
vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldinner = " ", foldclose = "" }
o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

o.winborder = "rounded"

o.undofile = true
o.undolevels = 10000

o.splitright = true
o.splitbelow = true
o.splitkeep = "screen"

o.signcolumn = "yes"
o.inccommand = "split"

o.cursorline = true
o.virtualedit = "block"

o.smoothscroll = true
o.sidescrolloff = 8
o.jumpoptions = "view"

o.confirm = true

o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
