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
			local sources = require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS")
			local conns = sources:load()

			local opts = {
				default_connection = os.getenv("DBEE_DEFAULT_CONNECTION") or (#conns > 0 and conns[1].name or nil),
				sources = {
					sources,
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
}
