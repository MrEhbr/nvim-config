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

local augroup = vim.api.nvim_create_augroup("numbertoggle", {})

autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
			vim.opt.relativenumber = true
		end
	end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		if vim.o.nu then
			vim.opt.relativenumber = false
			vim.cmd("redraw")
		end
	end,
})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

autocmd("FileType", {
	pattern = "dap-float",
	command = "nnoremap <buffer><silent> q <cmd>close!<CR>",
})

-- local inline_fold = vim.api.nvim_create_augroup("inline_fold", {})
--
-- autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
-- 	pattern = { "*.html", "*.jsx", "*.tsx", "*.svelte", "*.vue", "*.templ" },
-- 	group = inline_fold,
-- 	callback = function()
-- 		vim.opt.conceallevel = 2 -- Concealed text is completely hidden
--
-- 		local bufnr = vim.api.nvim_get_current_buf()
-- 		local conceal_ns = vim.api.nvim_create_namespace("class_conceal")
--
-- 		---Conceal HTML class attributes. Ideal for big TailwindCSS class lists
-- 		---Ref: https://gist.github.com/mactep/430449fd4f6365474bfa15df5c02d27b
-- 		local language_tree = vim.treesitter.get_parser(bufnr, "html")
-- 		local syntax_tree = language_tree:parse()
-- 		local root = syntax_tree[1]:root()
--
-- 		local query = [[
--         ((attribute
--           (attribute_name) @att_name (#eq? @att_name "class")
--           (quoted_attribute_value (attribute_value) @class_value) (#set! @class_value conceal "…")))
--         ]]
--
-- 		local ok, ts_query = pcall(vim.treesitter.query.parse, "html", query)
-- 		if not ok then
-- 			return
-- 		end
--
-- 		for _, captures, metadata in ts_query:iter_matches(root, bufnr, root:start(), root:end_(), {}) do
-- 			local start_row, start_col, end_row, end_col = captures[2]:range()
-- 			-- This conditional prevents conceal leakage if the class attribute is erroneously formed
-- 			if (end_row - start_row) == 0 then
-- 				vim.api.nvim_buf_set_extmark(bufnr, conceal_ns, start_row, start_col, {
-- 					end_line = end_row,
-- 					end_col = end_col,
-- 					conceal = metadata[2].conceal,
-- 				})
-- 			end
-- 		end
-- 	end,
-- })
