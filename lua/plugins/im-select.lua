return {
	"keaising/im-select.nvim",
	enabled = vim.loop.os_uname().sysname == "Darwin",
	config = function()
		require("im_select").setup({})
	end,
}
