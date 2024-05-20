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
	{ "ThePrimeagen/harpoon", lazy = false },
	{ "folke/which-key.nvim", lzay = false, opts = {} },
	{
		"kylechui/nvim-surround",
		branch = "main",
		event = "VeryLazy",
		config = true,
	},
}
