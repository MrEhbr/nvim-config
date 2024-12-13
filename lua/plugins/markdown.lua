return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("obsidian").setup({
				ui = { enable = false },
				workspaces = {
					{
						name = "Vault",
						path = "~/Obsidian/Vault",
					},
					{
						name = "no-vault",
						path = function()
							return assert(vim.fn.getcwd())
							-- return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
						end,
						overrides = {
							notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
							new_notes_location = "current_dir",
							templates = {
								folder = vim.NIL,
							},
							disable_frontmatter = true,
						},
					},
				},
				-- daily_notes = {
				-- 	folder = "~/Obsidian/Vault/06 - Daily",
				-- 	date_format = "%Y-%m-%d",
				-- 	default_tags = { "daily" },
				-- 	template = "(TEMPLATE) Daily",
				-- },
				completion = {
					nvim_cmp = true,
					min_chars = 2,
				},
				mappings = {
					["lf"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
					-- Toggle check-boxes.
					["<leader>ch"] = {
						action = function()
							return require("obsidian").util.toggle_checkbox()
						end,
						opts = { buffer = true },
					},
					-- Smart action depending on context, either follow link or toggle checkbox.
					["<cr>"] = {
						action = function()
							return require("obsidian").util.smart_action()
						end,
						opts = { buffer = true, expr = true },
					},
				},

				new_notes_location = "notes_subdir",

				---@param title string|?
				---@return string
				note_id_func = function(title)
					local suffix = ""
					if title ~= nil then
						suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					else
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return tostring(os.time()) .. "-" .. suffix
				end,

				wiki_link_func = function(opts)
					return require("obsidian.util").wiki_link_id_prefix(opts)
				end,

				markdown_link_func = function(opts)
					return require("obsidian.util").markdown_link(opts)
				end,

				preferred_link_style = "markdown",
				disable_frontmatter = false,

				---@return table
				note_frontmatter_func = function(note)
					if note.title then
						note:add_alias(note.title)
					end

					local out = { id = note.id, aliases = note.aliases, tags = note.tags }
					if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
						for k, v in pairs(note.metadata) do
							out[k] = v
						end
					end

					return out
				end,

				templates = {
					folder = "99 - Meta/00 - Templates",
					date_format = "%Y-%m-%d",
					time_format = "%H:%M",
					substitutions = {},
				},

				---@param url string
				follow_url_func = function(url)
					vim.fn.jobstart({ "open", url })
				end,

				---@diagnostic disable-next-line: missing-fields
				picker = {
					name = "telescope.nvim",
					mappings = {
						new = "<C-x>",
						insert_link = "<C-l>",
					},
					tag_mappings = {
						tag_note = "<C-x>",
						insert_tag = "<C-l>",
					},
				},
				sort_by = "modified",
				sort_reversed = true,
				search_max_lines = 1000,
				open_notes_in = "current",

				attachments = {
					img_folder = "98 - Meta/01 - Images",
					confirm_img_paste = true,

					---@return string
					img_name_func = function()
						return string.format("%s-", os.time())
					end,

					---@param client obsidian.Client
					---@param path obsidian.Path the absolute path to the image file
					---@return string
					img_text_func = function(client, path)
						path = client:vault_relative_path(path) or path
						return string.format("![%s](%s)", path.name, path)
					end,
				},
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
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },

		opts = {},
	},
}
