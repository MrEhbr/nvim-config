return {
	enabled = vim.loop.os_uname().sysname == "Darwin",
	"keaising/im-select.nvim",
	enable = false,
	config = function()
		require("im_select").setup({
			default_im_select = "com.apple.keylayout.ABC",
		})
	end,
}
