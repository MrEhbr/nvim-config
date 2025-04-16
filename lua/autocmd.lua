local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
	pattern = "*",
	command = "tabdo wincmd =",
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
