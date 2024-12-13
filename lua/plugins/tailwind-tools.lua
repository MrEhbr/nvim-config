-- tailwind-tools.lua
return {
	"luckasRanarison/tailwind-tools.nvim",
	name = "tailwind-tools",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim", -- optional
		"neovim/nvim-lspconfig", -- optional
	},
	opts = {
		server = {
			override = true, -- setup the server from the plugin if true
			settings = {
				experimental = {
					classRegex = {
						[[class="([^"]*)]],
						'class=\\s+"([^"]*)',
						'class:\\s+"([^"]*)',
						'class\\s*:\\s*"([^"]*)',
					},
				},
			},
		},
		extension = {
			patterns = {
				rust = {
					[[class="([^"]*)]],
					'class=\\s+"([^"]*)',
					'class:\\s+"([^"]*)',
					'class\\s*:\\s*"([^"]*)',
				},
			},
		},
	},
	config = function(_, opts)
		require("tailwind-tools").setup(opts)
	end,
}
