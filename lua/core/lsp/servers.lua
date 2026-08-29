vim.lsp.config("gopls", {
	filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
	settings = {
		gopls = {
			templateExtensions = { "tmpl" },
			analyses = {
				unreachable = true,
				nilness = true,
				unusedparams = true,
				useany = true,
				unusedwrite = true,
				ST1003 = true,
				ST1000 = false,
				undeclaredname = true,
				fillreturns = true,
				nonewvars = true,
				fieldalignment = false,
				shadow = true,
			},
			codelenses = {
				gc_details = false,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
			matcher = "Fuzzy",
			diagnosticsDelay = "500ms",
			symbolMatcher = "fuzzy",
			semanticTokens = false,
			directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				disable = { "missing-fields" },
				globals = {
					"vim",
					"Snacks",
				},
			},
			hint = {
				enable = true,
				setType = false,
				paramType = true,
				paramName = "Disable",
				semicolon = "Disable",
				arrayIndex = "Disable",
			},
		},
	},
})

vim.lsp.config("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			format = { enable = true, singleQuote = true, bracketSpacing = true },
			validate = true,
			completion = true,
			editor = { formatOnType = true },
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
})

vim.lsp.config("intelephense", {
	init_options = {
		licenceKey = os.getenv("INTELEPHENSE_KEY"),
	},
})

vim.lsp.config("tailwindcss", {
	filetypes = vim.list_extend(vim.deepcopy(vim.lsp.config.tailwindcss.filetypes), { "rust" }),
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					{ 'class: "(.*)"' },
				},
			},
			includeLanguages = {
				rust = "html",
			},
		},
	},
})
