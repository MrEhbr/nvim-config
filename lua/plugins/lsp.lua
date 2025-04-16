return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "b0o/schemastore.nvim" },
			{ "nanotee/sqls.nvim" },
		},
		config = function()
			require("plugins.config.lsp")
		end,
	},
}
