return {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	dependencies = { "folke/twilight.nvim", config = true },
	config = function()
		require("zen-mode").setup({
			window = {
				backdrop = 0.9,
				width = 1, -- This leaves enough space for the line numbers column + 80 characters
				height = 1,
				options = {
					signcolumn = "no",
					list = false,
				},
			},
			plugins = {
				options = {
					enabled = true,
					colorcolumn = false,
					ruler = false,
					showcmd = false,
				},
				gitsigns = { enabled = false },
				twilight = { enabled = true },
				diagnostics = { enabled = true },
			},
		})
		require("twilight").setup({
			dimming = {
				alpha = 0.25,
				color = { "Normal", "#ffffff" },
				term_bg = "#000000",
				inactive = false,
			},
			context = 10,
			treesitter = true,
			exclude = {},
		})
	end,
}
