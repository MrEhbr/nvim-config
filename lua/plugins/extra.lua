return {
	{ "christoomey/vim-tmux-navigator", lazy = false },
	{ "tpope/vim-sleuth", lazy = false },
	{ "tpope/vim-obsession", lazy = false },
	{
		"direnv/direnv.vim",
		lazy = false,
	},
	{ "folke/which-key.nvim", lazy = false, opts = {} },
	{
		"nvchad/showkeys",
		cmd = "ShowkeysToggle",
		opts = {
			timeout = 1,
			maxkeys = 6,
			position = "bottom-right",
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
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {
			view_options = { show_hidden = true },
			keymaps = {
				["q"] = "actions.close",
				["<C-v>"] = { "actions.select", opts = { vertical = true } },
				["<C-s>"] = { "actions.select", opts = { horizontal = true } },
			},
		},
		keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent directory" } },
	},
}
