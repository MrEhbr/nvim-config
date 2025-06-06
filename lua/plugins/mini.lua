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

			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			require("mini.comment").setup({
				options = {
					ignore_blank_line = true,
				},
				mappings = {
					-- Toggle comment (like `gcip` - comment inner paragraph) for both
					-- Normal and Visual modes
					comment = "<leader>/",

					-- Toggle comment on current line
					comment_line = "<leader>/",

					-- Toggle comment on visual selection
					comment_visual = "<leader>/",

					-- Define 'comment' textobject (like `dgc` - delete whole comment block)
					-- Works also in Visual mode if mapping differs from `comment_visual`
					textobject = "<leader>/",
				},
			})

			require("mini.pairs").setup({})
		end,
	},
}
