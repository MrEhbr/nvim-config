return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ ft = "lua", "folke/neodev.nvim", opts = {} },
			{ "b0o/schemastore.nvim" },
		},
		config = function()
			require("plugins.config.lsp")
		end,
	},
}
