local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

local file_ignore_patterns = {
	"%.pb%.go$", -- Ignore protobuf generated files
	"/_test%.go$", -- Ignore test files (assuming they end with _test.go)
	"/mocks?/", -- Ignore files in mock or mocks directories
	"/generated/", -- Ignore files in generated directories
	"%.gen%.go$", -- Ignore generated Go files (if they use this naming convention)
}

local function keymap(mode, l, r, desc)
	opts = {}
	opts.buffer = true
	opts.desc = string.format("Lsp: %s", desc)
	vim.keymap.set(mode, l, r, opts)
end

local on_attach = function(_, _)
	keymap("n", "<leader>lr", function()
		vim.lsp.buf.rename()
	end, "Rename")
	keymap("n", "<leader>ca", function()
		vim.lsp.buf.code_action({})
	end, "[C]ode [A]ction")

	keymap("n", "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	keymap("n", "gr", function()
		require("telescope.builtin").lsp_references({
			show_line = false,
			include_declaration = false,
			file_ignore_patterns = file_ignore_patterns,
		})
	end, "[G]oto [R]eferences")
	keymap("n", "gi", function()
		require("telescope.builtin").lsp_implementations({
			show_line = false,
			file_ignore_patterns = file_ignore_patterns,
		})
	end, "[G]oto [I]mplementation")
	keymap("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	keymap("n", "<leader>ld", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	keymap("n", "<leader>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	keymap("n", "<leader>fm", function()
		vim.lsp.buf.format({ async = true })
	end, "[f]or[m]at currenc buffer")

	keymap("n", "K", function()
		vim.lsp.buf.hover({ border = "single" })
	end, "Hover Documentation")
	keymap("i", "<C-s>", function()
		vim.lsp.buf.signature_help({ border = "single", focusable = false, relative = "cursor" })
	end, { desc = "Hover" })

	keymap("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
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

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = "󰋼 ",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})

vim.diagnostic.config({
	signs = true,
	underline = true,
	update_in_insert = false,
	virtual_lines = true,
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
	enabled = true,
	on_attach = on_attach,
	capabilities = capabilities,

	settings = {
		["harper-ls"] = {
			userDictPath = "~/.config/harper/dict.txt",
			fileDictPath = "~/.config/harper/",

			-- Severity can be "hint", "information", "warning", or "error".
			diagnosticSeverity = "hint",
			isolateEnglish = true,

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
