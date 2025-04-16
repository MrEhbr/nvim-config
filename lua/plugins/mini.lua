return {
	{
		"goolord/alpha-nvim",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
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

			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
}
