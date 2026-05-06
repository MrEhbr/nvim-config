return {
	{
		"dmtrKovalenko/fff.nvim",
		lazy = false,
		build = function()
			require("fff.download").download_or_build_binary()
		end,
		opts = {
			prompt = "> ",
			layout = {
				width = 0.9,
				height = 0.8,
				prompt_position = "top",
				preview_position = "right",
				preview_size = 0.6,
				anchor = "center",
				show_scrollbar = false,
			},
			debug = {
				enabled = false,
				show_scores = false,
			},
		},
		keys = {
			{
				"<leader>ff",
				function()
					require("fff").find_files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
				end,
				desc = "Find Grep",
			},
			{
				"<leader>fw",
				function()
					require("fff").live_grep({ query = vim.fn.expand("<cword>") })
				end,
				mode = { "n", "x" },
				desc = "Grep Word",
			},
		},
	},
}
