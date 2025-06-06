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
		"nvchad/showkeys",
		cmd = "ShowkeysToggle",
		lazy = false,
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
			max_file_size = "300kb",
			on_events = { "InsertLeave", "CursorHoldI" },
			cursor_line_only = true,
			default_config = {
				max_length = 40, -- shorten long crumbs
				min_distance = 8, -- don’t draw for tiny scopes
			},

			language_config = {
				json = { disabled = true },
				css = { disabled = true },
				html = { disabled = true },
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
	{ "hiphish/rainbow-delimiters.nvim", submodules = false, lazy = true, event = "BufReadPre" },
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		enabled = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	},
}
