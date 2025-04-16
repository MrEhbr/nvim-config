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
		end,
	},
}
