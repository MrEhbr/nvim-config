return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.basics").setup({
				options = {
					basic = true,
					extra_ui = false,
					win_borders = "bold",
				},
				mappings = {
					basic = true,
					option_toggle_prefix = "",
					windows = true,
					move_with_alt = true,
				},

				autocommands = {
					basic = true,
					relnum_in_visual_mode = true,
				},
				silent = false,
			})

			require("mini.ai").setup({ n_lines = 500 })

			require("mini.surround").setup({
				mappings = {
					add = "ys",
					delete = "ds",
					replace = "cs",
					find = "",
					find_left = "",
					highlight = "",
					update_n_lines = "",
				},
			})

			require("mini.comment").setup({
				options = {
					ignore_blank_line = true,
				},
				mappings = {
					comment = "<leader>/",
					comment_line = "<leader>/",
					comment_visual = "<leader>/",
					textobject = "<leader>/",
				},
			})

			require("mini.pairs").setup({})
		end,
	},
}
