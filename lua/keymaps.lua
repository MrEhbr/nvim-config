-- go to  beginning and end
vim.keymap.set("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "End of line" })

-- navigate within insert mode
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })

vim.keymap.set("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })

-- switch between windows
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
--
-- save
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })

-- Copy all
vim.keymap.set("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
vim.keymap.set({ "n", "x" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
vim.keymap.set({ "n", "x" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
vim.keymap.set({ "n", "v" }, "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
vim.keymap.set(
	{ "n", "v" },
	"<Down>",
	'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
	{ desc = "Move down", expr = true }
)

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("v", "<", "<gv", { desc = "Indent line" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent line" })

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
vim.keymap.set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Dont copy replaced text", silent = true })

vim.keymap.set("n", ";", ":", { nowait = true, desc = "Enter Command Mode" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { nowait = true, desc = "Page Down and Center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { nowait = true, desc = "Page Up and Center" })

-- Tmux navigation
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Window left" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Window right" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Window Up" })

-- Resize splits with Alt + arrow keys
vim.keymap.set("n", "<M-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<M-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<M-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Close current split
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
