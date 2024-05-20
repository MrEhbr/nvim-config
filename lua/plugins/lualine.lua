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

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"AndreM222/copilot-lualine",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		active = true,
		options = {
			theme = "auto",
			component_separators = "|",
			section_separators = { left = "", right = "" },
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
					fmt = function(str)
						if vim.api.nvim_strwidth(str) > 30 then
							return ("%s..."):format(str:sub(1, 29))
						end

						return str
					end,
				},
			},
			lualine_c = {
				{ "diff", source = diff_source, symbols = { added = " ", modified = " ", removed = " " } },
			},

			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
				},
				{
					"copilot",
					-- Default values
					symbols = {
						status = {
							icons = {
								enabled = " ",
								sleep = " ", -- auto-trigger disabled
								disabled = " ",
								warning = " ",
								unknown = " ",
							},
							hl = {
								enabled = "#50FA7B",
								sleep = "#AEB7D0",
								disabled = "#6272A4",
								warning = "#FFB86C",
								unknown = "#FF5555",
							},
						},
						spinners = { "∙∙∙", "●∙∙", "∙●∙", "∙∙●", "∙∙∙" },
						spinner_color = "#6272A4",
					},
					show_colors = false,
					show_loading = true,
				},
			},
		},
	},
	lualine_y = { "filetype" },
	lualine_z = {
		{ "progress", icon = "", separator = { right = "" } },
		inactive_sections = {
			lualine_a = { "filename" },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { "location" },
		},
		tabline = {},
		extensions = {},
		extensions = { "nvim-tree", "nvim-dap-ui" },
	},
}
