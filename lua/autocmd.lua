local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

vim.api.nvim_create_autocmd("Filetype", {
	group = vim.api.nvim_create_augroup("sql_keymap", {}),
	pattern = "sql",
	callback = function()
		vim.keymap.del('i', '<left>', { buffer = true })
		vim.keymap.del('i', '<right>', { buffer = true })
	end
})

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
	pattern = "*",
	command = "tabdo wincmd =",
})

autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
	pattern = "*",
	group = vim.api.nvim_create_augroup("numbertoggle", {}),
	callback = function()
		if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
			vim.opt.relativenumber = true
		end
	end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
	pattern = "*",
	group = vim.api.nvim_create_augroup("numbertoggle", {}),
	callback = function()
		if vim.o.nu then
			vim.opt.relativenumber = false
			vim.cmd("redraw")
		end
	end,
})

autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
	pattern = "*",
})

autocmd("FileType", {
	pattern = "dap-float",
	command = "nnoremap <buffer><silent> q <cmd>close!<CR>",
})

autocmd({ "CursorHold" }, {
	group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

-- Return to last edit position when opening files
autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("LastPosition", { clear = true }),
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.cmd('normal! g`"')
			vim.cmd("normal! zz")
		end
	end,
})

autocmd("CursorHold", {
	group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true }),
	pattern = "*",
	callback = function()
		if vim.lsp.buf.document_highlight then
			vim.lsp.buf.document_highlight()
		end
	end,
})
autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
	group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true }),
	pattern = "*",
	callback = function()
		if vim.lsp.buf.clear_references then
			vim.lsp.buf.clear_references()
		end
	end,
})
