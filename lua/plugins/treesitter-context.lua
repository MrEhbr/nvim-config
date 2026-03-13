return {
	"nvim-treesitter/nvim-treesitter-context",
	event = "BufReadPost",
	opts = { max_lines = 3 },
	keys = {
		{
			"[C",
			function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end,
			desc = "Go to context",
		},
	},
}
