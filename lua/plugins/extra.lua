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
}
