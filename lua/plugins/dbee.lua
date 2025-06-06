return {
	{
		"kndndrj/nvim-dbee",
		event = { "VeryLazy" },
		ft = { "sql" },
		dependencies = {
			"MunifTanjim/nui.nvim",
			-- { "vanducng/cmp-dbee", opts = {} },
		},
		keys = {
			{ "<M-p>", "<cmd>lua require('dbee').toggle()<cr>" },
		},
		build = function()
			require("dbee").install()
		end,
		config = function()
			local dbee = require("dbee")
			local envSource = require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS")
			local conns = envSource:load()

			local opts = {
				default_connection = os.getenv("DBEE_DEFAULT_CONNECTION") or (#conns > 0 and conns[1].name or nil),
				sources = {
					envSource,
					-- // ~/.config/dbee/persistence.json
					require("dbee.sources").FileSource:new(vim.fn.expand("$HOME/.config/dbee/persistence.json")),
				},
				editor = {
					mappings = {
						{ key = "<leader>E", mode = "v", action = "run_selection", opts = { desc = "Run selection" } },
						{
							key = "<leader>e",
							mode = "n",
							action = "run_under_cursor",
							opts = { desc = "Run under cursor" },
						},
					},
				},
			}
			dbee.setup(opts)
		end,
	},
}
