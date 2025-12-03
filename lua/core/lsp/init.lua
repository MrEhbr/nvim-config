vim.lsp.enable({
	"gopls",
	"lua_ls",
	"intelephense",
	"rust-analyzer",
	"yamlls",
	"jsonls",
	-- "harper_ls",
	-- "postgres_lsp",
	"tailwindcss",
	"marksman",
	"nil_ls",
	"templ",
	"dartls",
	"biome",
	"copilot",
	"jdtls",
})

vim.lsp.inline_completion.enable()

vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = false,
			},
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
			completion = {
				completionItem = {
					documentationFormat = { "markdown", "plaintext" },
					snippetSupport = true,
					preselectSupport = true,
					insertReplaceSupport = true,
					labelDetailsSupport = true,
					deprecatedSupport = true,
					commitCharactersSupport = true,
					tagSupport = { valueSet = { 1 } },
					resolveSupport = {
						properties = {
							"documentation",
							"detail",
							"additionalTextEdits",
						},
					},
				},
			},
		},
	},
	root_markers = { ".git" },
})

vim.highlight.priorities.semantic_tokens = 95
vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "single",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- defaults:
		-- https://neovim.io/doc/user/news-0.11.html#_defaults

		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
		map("gD", vim.lsp.buf.declaration, "Goto Declaration")
		map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map("<leader>la", vim.lsp.codelens.run, "Run Code Lens Action")
		map("<leader>fm", vim.lsp.buf.format, "Format")
		map("<leader>lr", vim.lsp.buf.rename, "Rename Symbol")
		map("<leader>lh", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, "Toggle Inlay Hints")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		-- Add code lens support
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
				buffer = event.buf,
				group = vim.api.nvim_create_augroup("lsp-codelens", { clear = false }),
				callback = function()
					vim.lsp.codelens.refresh()
				end,
			})

			-- Initial refresh
			vim.lsp.codelens.refresh()
		end

		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, event.buf) then
			vim.keymap.set("i", "<M-]>", function()
				vim.lsp.inline_completion.select({ count = 1 })
			end, { buffer = event.buf, desc = "Next inline completion" })

			vim.keymap.set("i", "<M-[>", function()
				vim.lsp.inline_completion.select({ count = -1 })
			end, { buffer = event.buf, desc = "Previous inline completion" })
		end

		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

			-- When cursor stops moving: Highlights all instances of the symbol under the cursor
			-- When cursor moves: Clears the highlighting
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			-- When LSP detaches: Clears the highlighting
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end
	end,
})

-- Commands

local complete_client = function(arg)
	local seen = {}
	return vim.iter(vim.lsp.get_clients())
		:map(function(client)
			return client.name
		end)
		:filter(function(name)
			if seen[name] or name:sub(1, #arg) ~= arg then
				return false
			end
			seen[name] = true
			return true
		end)
		:totable()
end

local complete_config = function(arg)
	return vim.iter(vim.api.nvim_get_runtime_file(("lsp/%s*.lua"):format(arg), true))
		:map(function(path)
			local file_name = path:match("[^/]*.lua$")
			return file_name:sub(0, #file_name - 4)
		end)
		:totable()
end

vim.api.nvim_create_user_command("LspStatus", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	local diagnostics = vim.diagnostic.get(bufnr)
	local errors = #vim.tbl_filter(function(d)
		return d.severity == vim.diagnostic.severity.ERROR
	end, diagnostics)
	local warnings = #vim.tbl_filter(function(d)
		return d.severity == vim.diagnostic.severity.WARN
	end, diagnostics)

	print(string.format("Buffer: %d | Filetype: %s", bufnr, vim.bo.filetype))
	print(string.format("Diagnostics: %d errors, %d warnings", errors, warnings))
	print(string.rep("-", 40))

	if #clients == 0 then
		print("No LSP clients attached")
		return
	end

	for _, client in ipairs(clients) do
		local status = client:is_stopped() and "stopped" or "running"
		local buf_count = vim.tbl_count(client.attached_buffers or {})
		print(string.format("%s [%s] (id: %d)", client.name, status, client.id))
		print(string.format("  root: %s", client.root_dir or "nil"))
		print(string.format("  buffers: %d", buf_count))
	end

	print(string.rep("-", 40))
	print(string.format("Log: %s", vim.lsp.log.get_filename()))
end, { desc = "Show LSP clients status" })

vim.api.nvim_create_user_command("LspStart", function(info)
	local servers = info.fargs

	if #servers == 0 then
		local filetype = vim.bo.filetype
		for _, name in ipairs(complete_config("")) do
			local config = vim.lsp.config[name]
			if config and config.filetypes and vim.tbl_contains(config.filetypes, filetype) then
				table.insert(servers, name)
			end
		end
	end

	vim.lsp.enable(servers)
end, {
	desc = "Enable and launch a language server",
	nargs = "?",
	complete = complete_config,
})

vim.api.nvim_create_user_command("LspRestart", function(info)
	local client_names = info.fargs

	if #client_names == 0 then
		client_names = vim.iter(vim.lsp.get_clients())
			:map(function(client)
				return client.name
			end)
			:totable()
	end

	for name in vim.iter(client_names) do
		if vim.lsp.config[name] == nil then
			vim.notify(("Invalid server name '%s'"):format(name))
		else
			vim.lsp.enable(name, false)
			if info.bang then
				vim.iter(vim.lsp.get_clients({ name = name })):each(function(client)
					client:stop(true)
				end)
			end
		end
	end

	local timer = assert(vim.uv.new_timer())
	timer:start(500, 0, function()
		for name in vim.iter(client_names) do
			vim.schedule_wrap(vim.lsp.enable)(name)
		end
	end)
end, {
	desc = "Restart the given client",
	nargs = "?",
	bang = true,
	complete = complete_client,
})

vim.api.nvim_create_user_command("LspStop", function(info)
	local client_names = info.fargs

	if #client_names == 0 then
		client_names = vim.iter(vim.lsp.get_clients())
			:map(function(client)
				return client.name
			end)
			:totable()
	end

	for name in vim.iter(client_names) do
		if vim.lsp.config[name] == nil then
			vim.notify(("Invalid server name '%s'"):format(name))
		else
			vim.lsp.enable(name, false)
			if info.bang then
				vim.iter(vim.lsp.get_clients({ name = name })):each(function(client)
					client:stop(true)
				end)
			end
		end
	end
end, {
	desc = "Disable and stop the given client",
	nargs = "?",
	bang = true,
	complete = complete_client,
})
