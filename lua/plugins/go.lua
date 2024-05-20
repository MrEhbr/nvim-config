return {
	"zgs225/gomodifytags.nvim",
	cmd = { "GoAddTags", "GoRemoveTags" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("gomodifytags").setup()
	end,
}
