local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local copilot_icons = {
	Error = { " ", "DiagnosticError" },
	Inactive = { " ", "MsgArea" },
	Warning = { " ", "DiagnosticWarn" },
	Normal = { " ", "Special" },
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lualine").setup({
			active = true,
			options = {
				theme = "auto",
				component_separators = "|",
				section_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { left = "" }, right_padding = 2, icon = "" },
				},
				lualine_b = {
					{ "filename", path = 1, file_status = false },
					{
						"b:gitsigns_head",
						icon = "",
					},
				},
				lualine_c = {
					{
						"diff",
						source = diff_source,
						symbols = { added = " ", modified = " ", removed = " " },
						colored = true,
						diff_color = {
							added = { fg = "#98be65" },
							modified = { fg = "#ecbe7b" },
							removed = { fg = "#ec5f67" },
						},
					},
				},
				lualine_x = {
					{
						"diagnostics",
						color = { gui = "bold" },
					},
					{
						function()
							local status = require("sidekick.status").get()
							return status and vim.tbl_get(copilot_icons, status.kind, 1)
						end,
						cond = function()
							return require("sidekick.status").get() ~= nil
						end,
						color = function()
							local status = require("sidekick.status").get()
							local hl = status
								and (status.busy and "DiagnosticWarn" or vim.tbl_get(copilot_icons, status.kind, 2))
							return { fg = Snacks.util.color(hl) }
						end,
					},
				},
				lualine_y = { "filetype" },
				lualine_z = {
					{ "progress", separator = { right = "" } },
				},
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
		})
	end,
}
