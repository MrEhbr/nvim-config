return {
	{
		"epwalsh/obsidian.nvim",
		event = { "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**.md" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("obsidian").setup({

				workspaces = {
					{
						name = "vault",
						path = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault"),
					},
				},
				daily_notes = {
					folder = "journal/daily",
					date_format = "%Y-%m-%d",
				},
				completion = {
					nvim_cmp = true,
					min_chars = 2,
					new_notes_location = "current_dir",
					prepend_note_id = true,
					prepend_note_path = false,
					use_path_only = false,
				},
				mappings = {
					-- 	-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
					-- 	["gf"] = require("obsidian.mapping").gf_passthrough(),
				},

				note_id_func = function(title)
					local suffix = ""
					if title ~= nil then
						suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					else
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return suffix
				end,
				disable_frontmatter = true,
				templates = {
					subdir = "_config/templates",
					date_format = "%Y-%m-%d",
					time_format = "%H:%M",
				},
				backlinks = { height = 10, wrap = true },
				follow_url_func = function(url)
					vim.fn.jobstart({ "open", url })
				end,
				use_advanced_uri = false,
				open_app_foreground = false,
				finder = "telescope.nvim",
				open_notes_in = "current",
			})
		end,
		cmd = {
			"ObsidianBacklinks",
			"ObsidianFollowLink",
			"ObsidianLink",
			"ObsidianLinkNew",
			"ObsidianNew",
			"ObsidianOpen",
			"ObsidianPasteImg",
			"ObsidianQuickSwitch",
			"ObsidianRename",
			"ObsidianSearch",
			"ObsidianTemplate",
			"ObsidianToday",
			"ObsidianTomorrow",
			"ObsidianWorkspace",
			"ObsidianYesterday",
		},
	},
	{
		"ellisonleao/glow.nvim",
		config = function(_, _)
			require("glow").setup({
				border = "rounded",
				style = "dracula",
				width = 160,
				height_ratio = 0.8,
			})
		end,
		cmd = "Glow",
	},
}
