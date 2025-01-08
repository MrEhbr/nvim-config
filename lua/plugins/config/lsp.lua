local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

local function lspSymbol(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

local file_ignore_patterns = {
	"%.pb%.go$", -- Ignore protobuf generated files
	"/_test%.go$", -- Ignore test files (assuming they end with _test.go)
	"/mocks?/", -- Ignore files in mock or mocks directories
	"/generated/", -- Ignore files in generated directories
	"%.gen%.go$", -- Ignore generated Go files (if they use this naming convention)
}

local on_attach = function(client, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, {
			buffer = bufnr,
			desc = desc,
			remap = false,
		})
	end

	nmap("<leader>lr", function()
		vim.lsp.buf.rename()
	end, "Rename")
	nmap("<leader>ca", function()
		vim.lsp.buf.code_action({})
	end, "[C]ode [A]ction")

	nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	nmap("gr", function()
		require("telescope.builtin").lsp_references({
			show_line = false,
			include_declaration = false,
			file_ignore_patterns = file_ignore_patterns,
		})
	end, "[G]oto [R]eferences")
	nmap("gi", function()
		require("telescope.builtin").lsp_implementations({
			show_line = false,
			file_ignore_patterns = file_ignore_patterns,
		})
	end, "[G]oto [I]mplementation")
	nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	nmap("<leader>ld", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	nmap("<leader>fm", function()
		vim.lsp.buf.format({ async = true })
	end, "[f]or[m]at currenc buffer")

	nmap("K", "<cmd>:lua vim.lsp.buf.hover() <CR>", "Hover Documentation")
	-- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
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
}

-- need for kevinhwang91/nvim-ufo
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

lspSymbol("Error", "󰅙")
lspSymbol("Info", "󰋼")
lspSymbol("Hint", "󰌵")
lspSymbol("Warn", "")

vim.diagnostic.config({
	virtual_text = {
		prefix = "",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
	focusable = false,
	relative = "cursor",
})

-- Provide default configuration for the following LSP servers:
local servers = {
	"marksman",
	"phpactor",
	"biome",
	"svelte",
	"pyright",
	"nil_ls",
	"eslint",
	"templ",
	"buf_ls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	flags = { debounce_text_changes = 200 },
	gopls = {
		formatting = {
			gofumpt = true,
		},
		experimentalPostfixCompletions = true,
		staticcheck = true,
	},
})

lspconfig.ts_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		preferences = {
			disableSuggestions = true,
		},
	},
})

lspconfig.htmx.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html" },
})

lspconfig.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

lspconfig.yamlls.setup({
	settings = {
		yaml = {
			format = { enable = true, singleQuote = true, bracketSpacing = true },
			validate = true,
			completion = true,
			editor = { formatOnType = true },
		},
		schemaStore = {
			enable = false,
			url = "",
		},
		schemas = require("schemastore").yaml.schemas(),
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.postgres_lsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "sql" },
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,

	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})

lspconfig.harper_ls.setup({
	enabled = false,
	on_attach = on_attach,
	capabilities = capabilities,

	settings = {
		["harper-ls"] = {
			userDictPath = "~/.config/harper/dict.txt",
			fileDictPath = "~/.config/harper/",

			-- Severity can be "hint", "information", "warning", or "error".
			diagnosticSeverity = "hint",

			linters = {
				spell_check = true,
				spelled_numbers = false,
				an_a = true,
				sentence_capitalization = false,
				unclosed_quotes = true,
				wrong_quotes = false,
				long_sentences = true,
				repeated_words = true,
				spaces = true,
				matcher = true,
				correct_number_suffix = true,
				number_suffix_capitalization = true,
				multiple_sequential_pronouns = true,
				linking_verbs = false,
				avoid_curses = true,
				terminating_conjunctions = true,
			},
			codeActions = {
				forceStable = true,
			},
		},
	},
})

return {
	on_attach = on_attach,
	capabilities = capabilities,
}
