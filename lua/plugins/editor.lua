return {
	{ "christoomey/vim-tmux-navigator", lazy = false },
	{ "tpope/vim-sleuth", lazy = false },
	{ "tpope/vim-obsession", lazy = false },
	{ "NoahTheDuke/vim-just", ft = { "just" } },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"nacro90/numb.nvim",
		lazy = false,
		config = true,
	},
	{ "folke/which-key.nvim", lzay = false, opts = {} },
	{
		"kylechui/nvim-surround",
		branch = "main",
		event = "VeryLazy",
		config = true,
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},
	{
		priority = 1000,
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			input = { enabled = true },
			image = { enabled = true, force = true },
			picker = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			scope = { enabled = true },
			dim = { enabled = true },
			-- statuscolumn = { enabled = true },
			-- words = { enabled = true },
			styles = {
				input = { relative = "cursor", row = -3, col = 0 },
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				override_vim_notify = true,
				window = {
					normal_hl = "Comment", -- Base highlight group in the notification window
					winblend = 50, -- Background color opacity in the notification window
					border = "none", -- Border around the notification window
					zindex = 45, -- Stacking priority of the notification window
					max_width = 0, -- Maximum width of the notification window
					max_height = 0, -- Maximum height of the notification window
					x_padding = 1, -- Padding from right edge of window boundary
					y_padding = 1, -- Padding from bottom edge of window boundary
					align = "bottom", -- How to align the notification window
					relative = "editor", -- What the notification window position is relative to
				},
			},
		},
	},
}
