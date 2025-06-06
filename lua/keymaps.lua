-----------------------------------------------------------------------------------
-- General Keymaps
-----------------------------------------------------------------------------------
-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })

-- Enter command mode more easily
vim.keymap.set("n", ";", ":", { nowait = true, desc = "Enter Command Mode" })

-- Save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })

-- Copy entire file content
vim.keymap.set("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })

-- Copy file name to clipboard
vim.keymap.set(
	"n",
	"<leader>fy",
	require("config.utils").copy_file_path_and_line_number,
	{ desc = "Copy File Path and Line Number" }
)

-----------------------------------------------------------------------------------
-- Navigation
-----------------------------------------------------------------------------------
-- Centered navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { nowait = true, desc = "Page Down and Center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { nowait = true, desc = "Page Up and Center" })

-- Go to beginning and end of line in insert mode
vim.keymap.set("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "End of line" })

-----------------------------------------------------------------------------------
-- Window Management
-----------------------------------------------------------------------------------
-- Tmux-like window navigation
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Window left" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Window right" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Window Up" })

-- Window resizing
vim.keymap.set("n", "<M-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<M-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<M-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Window splitting
vim.keymap.set("n", "<leader>-", "<cmd>split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Split window vertically" })

-----------------------------------------------------------------------------------
-- Text Editing
-----------------------------------------------------------------------------------
-- Better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent line" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent line" })

-- Don't copy the replaced text after pasting in visual mode
vim.keymap.set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Dont copy replaced text", silent = true })

-----------------------------------------------------------------------------------
-- Quickfix Navigation
-----------------------------------------------------------------------------------
-- vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Next quickfix" })
-- vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Previous quickfix" })
