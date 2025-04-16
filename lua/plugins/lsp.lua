return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "b0o/schemastore.nvim" },
			{ "nanotee/sqls.nvim", ft = { "sql" } },
		},
		config = function()
			require("plugins.config.lsp")
		end,
	},
}
