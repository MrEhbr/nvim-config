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
					{
						function()
							-- Check if MCPHub is loaded
							if not vim.g.loaded_mcphub then
								return "󰐻 -"
							end

							local count = vim.g.mcphub_servers_count or 0
							local status = vim.g.mcphub_status or "stopped"
							local executing = vim.g.mcphub_executing

							-- Show "-" when stopped
							if status == "stopped" then
								return "󰐻 -"
							end

							-- Show spinner when executing, starting, or restarting
							if executing or status == "starting" or status == "restarting" then
								local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
								local frame = math.floor(vim.loop.now() / 100) % #frames + 1
								return "󰐻 " .. frames[frame]
							end

							return "󰐻 " .. count
						end,
						color = function()
							if not vim.g.loaded_mcphub then
								return { fg = "#6c7086" } -- Gray for not loaded
							end

							local status = vim.g.mcphub_status or "stopped"
							if status == "ready" or status == "restarted" then
								return { fg = "#50fa7b" } -- Green for connected
							elseif status == "starting" or status == "restarting" then
								return { fg = "#ffb86c" } -- Orange for connecting
							else
								return { fg = "#ff5555" } -- Red for error/stopped
							end
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
