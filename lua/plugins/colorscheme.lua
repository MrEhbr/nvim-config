return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = true,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false,
			dimInactive = false,
			terminalColors = true,
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

					DapBreakpoint = { fg = theme.diag.ok, bold = true },
					DapLogPoint = { fg = "#61afef", bg = "#31353f", bold = true },
					DapStopped = { fg = "#98c379", bg = "#31353f", bold = true },
					DapLine = { bg = theme.diff.text },

					Pmenu = { fg = theme.ui.shade0, bg = "NONE" },
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = "#C0A36E" },
					BlinkCmpMenuBorder = { fg = "", bg = "" },
					CursorLineNr = { fg = colors.palette.sakuraPink, bg = "NONE" },
				}
			end,
			theme = "wave",
			background = {
				dark = "wave",
			},
		})

		vim.cmd("colorscheme kanagawa")
	end,
}
