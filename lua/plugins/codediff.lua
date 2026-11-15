return {
	{
		"esmuellert/codediff.nvim",
		version = "*",
		cmd = "CodeDiff",
		opts = {
			diff = {
				layout = "inline",
				compact = false,
				cycle_hunks_across_files = true,
			},
			explorer = { view_mode = "tree", auto_refresh = true, untracked = "all" },
		},
		keys = {
			{ "<leader>ae", "<cmd>CodeDiff<cr>", desc = "AI: explore working-tree changes (codediff)" },
			{ "<leader>aE", "<cmd>CodeDiff file HEAD<cr>", desc = "AI: diff current file vs HEAD" },
		},
	},
	{
		"MrEhbr/review.nvim",
		dependencies = { "esmuellert/codediff.nvim" },
		cmd = "Review",
		opts = {},
	},
}
