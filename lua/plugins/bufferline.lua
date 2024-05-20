return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		{
			"famiu/bufdelete.nvim",
			event = "VeryLazy",
		},
	},
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers",
				numbers = "none",
				close_command = "Bdelete! %d",
				--= right_mouse_command = "Bdelete! %d",
				left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
				middle_mouse_command = nil,
				indicator_icon = nil,
				indicator = { style = "icon", icon = "▎" },
				buffer_close_icon = "",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 30,
				max_prefix_length = 30,
				tab_size = 21,
				diagnostics = false,
				diagnostics_update_in_insert = false,
				-- offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
				show_buffer_icons = true,
				show_buffer_close_icons = false,
				show_close_icon = true,
				show_tab_indicators = true,
				persist_buffer_sort = true,
				separator_style = "thin",
				enforce_regular_tabs = true,
				always_show_bufferline = true,
			},
		})

		vim.keymap.set("n", "<leader><tab>", function()
			bufferline.pick()
		end, { desc = "Pick buffer" })
		vim.keymap.set("n", "<tab>", function()
			bufferline.cycle(1)
		end, { desc = "Next buffer" })
		vim.keymap.set("n", "<S-tab>", function()
			bufferline.cycle(-1)
		end, { desc = "Previous buffer" })
		vim.keymap.set("n", "<leader>x", function()
			require("bufdelete").bufdelete(0, false)
		end, { desc = "Close buffer" })
		vim.keymap.set("n", "<leader>X", function()
			bufferline.close_others()
		end, { desc = "Close all buffer except current" })
	end,
}
