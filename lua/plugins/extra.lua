return {
	{ "christoomey/vim-tmux-navigator", lazy = false },
	{ "tpope/vim-sleuth", lazy = false },
	{ "tpope/vim-obsession", lazy = false },
	{
		"nacro90/numb.nvim",
		lazy = false,
		config = true,
	},
	{
		"direnv/direnv.vim",
		lazy = false,
	},
	{ "folke/which-key.nvim", lzay = false, opts = {} },
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			stiffness = 0.8, -- 0.6      [0, 1]
			trailing_stiffness = 0.5, -- 0.4      [0, 1]
			stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
			trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
			distance_stop_animating = 0.5, -- 0.1      > 0
		},
	},
	{
		"nvchad/showkeys",
		cmd = "ShowkeysToggle",
		opts = {
			timeout = 1,
			maxkeys = 6,
			-- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
			position = "bottom-right",
		},
	},
	{
		"windwp/nvim-spectre",
		enabled = true,
		event = "BufRead",
		keys = {
			{
				"<leader>Rr",
				function()
					require("spectre").open()
				end,
				desc = "Replace",
			},
			{
				"<leader>Rw",
				function()
					require("spectre").open_visual({ select_word = true })
				end,
				desc = "Replace Word",
			},
			{
				"<leader>Rf",
				function()
					require("spectre").open_file_search()
				end,
				desc = "Replace Buffer",
			},
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup()
		end,
	},
	{
		"code-biscuits/nvim-biscuits",
		event = "BufReadPost",
		opts = {
			show_on_start = false,
			cursor_line_only = true,
			default_config = {
				min_distance = 10,
				max_length = 50,
				prefix_string = " 󰆘 ",
				prefix_highlight = "Comment",
				enable_linehl = true,
			},
		},
	},
	{
		"gbprod/cutlass.nvim",
		event = "BufReadPost",
		opts = {
			cut_key = "x",
			override_del = true,
			exclude = {},
			registers = {
				select = "_",
				delete = "_",
				change = "_",
			},
		},
	},
	{
		"hiphish/rainbow-delimiters.nvim",
		event = "BufReadPost",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},
}
