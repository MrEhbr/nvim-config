return {
	enabled = vim.loop.os_uname().sysname == "Darwin",
	"keaising/im-select.nvim",
	enable = true,
	config = function()
		require("im_select").setup({})
	end,
}
