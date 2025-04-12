return {
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
		opts = {},
	},
}
