return {
	"RRethy/vim-illuminate",
	event = "VeryLazy",
	config = function()
		require("illuminate").configure({
			providers = {
				"lsp",
				"treesitter",
				"regex",
			},
			delay = 100,
			filetypes_denylist = {
				"dirvish",
				"fugitive",
				"NvimTree",
				"Trouble",
				"TelescopePrompt",
				"Navbuddy",
				"Empty",
				"terminal",
			},
			modes_denylist = { "v", "vs", "V", "Vs", "CTRL-V", "CTRL-Vs" },
			under_cursor = true,
			min_count_to_highlight = 2,
		})
	end,
}
