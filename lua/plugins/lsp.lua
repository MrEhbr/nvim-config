return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "b0o/schemastore.nvim" },
			{ "nanotee/sqls.nvim" },
			{ "saghen/blink.cmp" },
		},
		config = function()
			require("plugins.config.lsp")
		end,
	},
}
