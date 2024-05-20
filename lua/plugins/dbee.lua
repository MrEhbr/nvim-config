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
			local TabLayout = require("config.dbee")

			dbee.setup({
				window_layout = TabLayout:new(),
				sources = {
					require("dbee.sources").FileSource:new(vim.fn.expand("$HOME/.config/dbee/persistence.json")),
				},
				editor = {
					mappings = {
						{ key = "<leader>E", mode = "v", action = "run_selection", opts = { desc = "Run selection" } },
						{ key = "<leader>e", mode = "n", action = "run_under_cursor", opts = { desc = "Run under cursor" } },
					},
				},
			})
		end,
	},
}
