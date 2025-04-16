return {
	{
		"kndndrj/nvim-dbee",
		event = { "VeryLazy" },
		ft = { "sql" },
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<M-p>", "<cmd>lua require('dbee').toggle()<cr>" },
		},
		build = function()
			require("dbee").install()
		end,
		config = function()
			local dbee = require("dbee")
			local opts = {
				sources = {
					require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
				},
				editor = {
					mappings = {
						{ key = "<leader>E", mode = "v", action = "run_selection", opts = { desc = "Run selection" } },
						{ key = "<leader>E", mode = "n", action = "run_file", opts = { desc = "Run file" } },
					},
				},
			}
			dbee.setup(opts)

			-- local dbee_connections = vim.tbl_filter(function(connection)
			-- 	return connection.url:find("env") == nil
			-- end, require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"):load())

			-- local sql_connections = {}
			-- for _, connection in ipairs(dbee_connections) do
			-- 	local sqls_conntection = {}
			-- 	sqls_conntection.alias = connection.name
			-- 	sqls_conntection.driver = connection.url:sub(0, connection.url:find(":") - 1)
			-- 	sqls_conntection.dataSourceName = connection.url
			-- 	sqls_conntection.name = nil
			-- 	sqls_conntection.url = nil
			-- 	if sqls_conntection.driver == "postgres" then
			-- 		sqls_conntection.driver = "postgresql"
			-- 	end
			-- 	table.insert(sql_connections, sqls_conntection)
			-- end

			-- require("lspconfig").sqls.setup({
			-- 	capabilities = require("plugins.config.lsp").capabilities,
			-- 	on_attach = function(client, bufnr)
			-- 		require("sqls").on_attach(client, bufnr)
			-- 		require("plugins.config.lsp").on_attach(client, bufnr)
			-- 	end,
			-- 	settings = {
			-- 		sqls = {
			-- 			connections = {
			-- 				{
			-- 					driver = "postgresql",
			-- 					dataSourceName = "postgres://postgres:pwd@localhost:5432/postgres?sslmode=disable",
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })
		end,
	},
	{
		"MattiasMTS/cmp-dbee",
		dependencies = {
			{ "kndndrj/nvim-dbee" },
		},
		ft = "sql",
		opts = {
			sources = {
				{ "cmp-dbee" },
			},
		},
	},
}
