return {
	"sindrets/diffview.nvim",
	event = "VeryLazy",
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

		local nmap = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { desc = desc })
		end

		nmap("<leader>hd", "<CMD> DiffviewOpen<CR>", "  Show Git Diff")
		nmap("<leader>hf", "<CMD> DiffviewFileHistory %<CR>", "  Show File History")
		nmap("<leader>hD", "<CMD> DiffviewOpen --cached<CR>", "  Show Staged Diffs")
		nmap("<leader>hx", "<CMD> DiffviewClose<CR>", "  Close Diff View")
	end,
}
