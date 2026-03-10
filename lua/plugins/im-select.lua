return {
	"keaising/im-select.nvim",
	enabled = vim.uv.os_uname().sysname == "Darwin",
	config = function()
		require("im_select").setup({})
	end,
}
