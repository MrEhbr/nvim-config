return {
	"rachartier/tiny-cmdline.nvim",
	lazy = false,
	init = function()
		vim.o.cmdheight = 0
		vim.o.showcmdloc = "statusline"
		require("vim._core.ui2").enable({})
	end,
	config = function()
		require("tiny-cmdline").setup({
			on_reposition = require("tiny-cmdline").adapters.blink,
		})
	end,
}
