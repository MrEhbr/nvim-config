return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		opts = function()
			return {
				ensure_installed = {
					"js-debug-adapter",
					"chrome-debug-adapter",
					"codelldb",
					"eslint-lsp",
					"json-lsp",
					-- "sql-formatter",
					-- "sqlls",
				},
			}
		end,
		config = function(_, opts)
			require("mason").setup(opts)

			vim.api.nvim_create_user_command("MasonInstallAll", function()
				if opts.ensure_installed and #opts.ensure_installed > 0 then
					vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
				end
			end, {})

			vim.g.mason_binaries_list = opts.ensure_installed
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"j-hui/fidget.nvim",
				opts = {
					notification = {
						window = {
							winblend = 0,
						},
					},
				},
			},
			{ ft = "lua", "folke/neodev.nvim", opts = {} },
			{ "b0o/schemastore.nvim" },
		},
		config = function()
			require("plugins.config.lsp")
		end,
	},
}
