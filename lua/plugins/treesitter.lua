return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"query",
				"markdown",
				"markdown_inline",
				"lua",
				"go",
				"rust",
				"php",
				"sql",
				"javascript",
				"typescript",
				"svelte",
				"fish",
				"vim",
				"dockerfile",
				"proto",
				"make",
				"templ",
				"html",
				"hurl",
				"regex",
				"bash",
				"diff",
				"yaml",
				"json",
			},
			auto_install = false,
			autotag = {
				enable = true,
			},
			highlight = {
				enable = true,
				use_languagetree = true,
			},

			indent = {
				enable = true,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					scope_incremental = "<CR>",
					node_incremental = "<TAB>",
					node_decremental = "<S-TAB>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.bruno = {
				install_info = {
					url = "https://github.com/Scalamando/tree-sitter-bruno",
					files = { "src/parser.c", "src/scanner.c" }, -- Add scanner.c to include external scanner
					branch = "main",
					generate_requires_npm = false, -- Don't require npm
					requires_generate_from_grammar = false, -- Don't regenerate from grammar
				},
				filetype = "bruno",
			}
		end,
	},
}
