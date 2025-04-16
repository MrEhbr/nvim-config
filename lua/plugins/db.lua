return {
	{
		"kndndrj/nvim-dbee",
		event = { "VeryLazy" },
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
