return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			heading = {
				-- Turn on / off heading icon & background rendering
				enabled = true,
				sign = false,
				-- icons = { " 󰼏 ", " 󰼐 ", " 󰼑 ", " 󰼒 ", " 󰼓 ", " 󰼔 " },
				icons = { " 󰎥 ", " 󰎨 ", " 󰎫 ", " 󰎲 ", " 󰎯 ", " 󰎴 " },
				-- icons = { " 󰎤 ", " 󰎧 ", " 󰎪 ", " 󰎭 ", " 󰎱 ", " 󰎳 " },
				-- icons = { " 󰉫 ", " 󰉬 ", " 󰉭 ", " 󰉮 ", " 󰉯 ", " 󰉰 " },
				signs = { " " },
				position = "inline",
				width = "block",
			},
			dash = {
				width = 120,
			},
			link = {
				-- Turn on / off inline link icon rendering
				enabled = true,
				-- Inlined with 'image' elements
				image = "  ",
				-- Inlined with 'inline_link' elements
				hyperlink = "󰌷 ",
				-- Applies to the inlined icon
				highlight = "RenderMarkdownLink",
			},
			code = {
				left_pad = 0,
				position = "right",
				min_width = 120,
				disable_background = true,
				border = "none",
			},
			checkbox = {
				unchecked = {
					icon = " ",
				},
				checked = {
					icon = " ",
					highlight = "RenderMarkdownChecked",
				},
				custom = {
					incomplete = { raw = "[/]", rendered = "󰡕 ", highlight = "RenderMarkdownInfo" },
					todo = { raw = "[-]", rendered = "󰜺 ", highlight = "RenderMarkdownQuote" },
					rescheduled = { raw = "[>]", rendered = "󰦛 ", highlight = "RenderMarkdownInfo" },
					scheduled = { raw = "[<]", rendered = " ", highlight = "RenderMarkdownChecked" },
					question = { raw = "[?]", rendered = " ", highlight = "RenderMarkdownWarn" },
					important = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownError" },
					star = { raw = "[*]", rendered = " ", highlight = "RenderMarkdownWarn" },
					quote = { raw = '["]', rendered = "󱀢 ", highlight = "RenderMarkdownUnchecked" },
					location = { raw = "[l]", rendered = " ", highlight = "RenderMarkdownQuote" },
					bookmark = { raw = "[b]", rendered = " ", highlight = "RenderMarkdownH6" },
					information = { raw = "[i]", rendered = "󰋼 ", highlight = "RenderMarkdownInfo" },
					amount = { raw = "[S]", rendered = "󱢐 ", highlight = "RenderMarkdownWarn" },
					idea = { raw = "[I]", rendered = " ", highlight = "RenderMarkdownHint" },
					con = { raw = "[c]", rendered = "󰔒 ", highlight = "RenderMarkdownQuote" },
					pro = { raw = "[p]", rendered = "󰔔 ", highlight = "RenderMarkdownSuccess" },
				},
			},
			callout = {
				note = { raw = "[!NOTE]", rendered = "󰙏 Note", highlight = "RenderMarkdownInfo" },
				info = { raw = "[!INFO]", rendered = "󰋽 Info", highlight = "RenderMarkdownInfo" },
				todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownInfo" },
				summary = { raw = "[!SUMMARY]", rendered = "󰨸 Summary", highlight = "RenderMarkdownHint" },
				abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownHint" },
				tldr = { raw = "[!TLDR]", rendered = "󰨸 Tldr", highlight = "RenderMarkdownHint" },
				tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownHint" },
				hint = { raw = "[!HINT]", rendered = "󰅾 Hint", highlight = "RenderMarkdownHint" },
				important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
				check = { raw = "[!CHECK]", rendered = "󰄬 Check", highlight = "RenderMarkdownSuccess" },
				done = { raw = "[!DONE]", rendered = "󰄬 Done", highlight = "RenderMarkdownSuccess" },
				success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
				question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
				help = { raw = "[!HELP]", rendered = "󰘥 Help", highlight = "RenderMarkdownWarn" },
				faq = { raw = "[!FAQ]", rendered = "󰘥 Faq", highlight = "RenderMarkdownWarn" },
				warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownQuote" },
				caution = { raw = "[!CAUTION]", rendered = "󰀪 Caution", highlight = "RenderMarkdownQuote" },
				attention = { raw = "[!ATTENTION]", rendered = "󰀪 Attention", highlight = "RenderMarkdownQuote" },
				failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "RenderMarkdownError" },
				fail = { raw = "[!FAIL]", rendered = "󰅖 Fail", highlight = "RenderMarkdownError" },
				missing = { raw = "[!MISSING]", rendered = "󰅖 Missing", highlight = "RenderMarkdownError" },
				danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "RenderMarkdownError" },
				error = { raw = "[!ERROR]", rendered = "󱐌 Error", highlight = "RenderMarkdownError" },
				bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
				example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownH6" },
				quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownUnchecked" },
			},
			quote = {
				repeat_linebreak = true,
			},
			pipe_table = {
				style = "normal",
				cell = "padded",
			},
		},
	},
}
