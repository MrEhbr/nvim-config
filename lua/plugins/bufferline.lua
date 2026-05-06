return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"famiu/bufdelete.nvim",
	},
	config = function()
		local bufferline = require("bufferline")
		local Path = require("plenary.path")

		local function harpoon_prefix(buf)
			local ok, harpoon = pcall(require, "harpoon")
			if not ok or not buf.path or buf.path == "" then
				return nil
			end
			local list = harpoon:list()
			local rel = Path:new(buf.path):make_relative(vim.loop.cwd())
			for i = 1, list:length() do
				local it = list.items[i]
				if it and it.value == rel then
					return i
				end
			end
		end

		bufferline.setup({
			options = {
				mode = "buffers",
				numbers = "none",
				name_formatter = function(buf)
					local slot = harpoon_prefix(buf)
					if slot then
						return "[" .. slot .. "] " .. buf.name
					end
					return buf.name
				end,
				close_command = "Bdelete! %d",
				left_mouse_command = "buffer %d",
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
				show_buffer_icons = true,
				show_buffer_close_icons = true,
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
