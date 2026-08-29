return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
	keys = {
		{ "<leader>hd", "<CMD>DiffviewOpen<CR>", desc = "  Show Git Diff" },
		{ "<leader>hf", "<CMD>DiffviewFileHistory %<CR>", desc = "  Show File History" },
		{ "<leader>hD", "<CMD>DiffviewOpen --cached<CR>", desc = "  Show Staged Diffs" },
		{ "<leader>hx", "<CMD>DiffviewClose<CR>", desc = "  Close Diff View" },
	},
	config = function()
		require("diffview").setup({
			diff_binaries = false,
			enhanced_diff_hl = false,
			use_icons = true,
			show_help_hints = true,
			watch_index = true,

			icons = {
				folder_closed = "",
				folder_open = "",
			},
			signs = {
				fold_closed = "",
				fold_open = "",
				done = "✓",
			},

			view = {
				default = {
					winbar_info = true,
				},
				merge_tool = {
					layout = "diff3_mixed",
				},
				file_history = {
					winbar_info = true,
				},
			},

			hooks = {
				diff_buf_read = function()
					vim.opt_local.wrap = false
					vim.opt_local.colorcolumn = ""
				end,
			},
		})
	end,
}
