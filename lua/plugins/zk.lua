return {
	"zk-org/zk-nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("zk").setup({
			picker = "telescope",
			picker_options = {
				telescope = require("telescope.themes").get_ivy(),
			},
			lsp = {
				config = {
					cmd = { "zk", "lsp" },
					name = "zk",
					on_attach = require("plugins.config.lsp").on_attach,
					capabilities = require("plugins.config.lsp").capabilities,
				},

				auto_attach = {
					enabled = true,
					filetypes = { "markdown" },
				},
			},
		})
	end,
}
