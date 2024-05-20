local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5
return {
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			filters = {
				dotfiles = false,
				git_ignored = false,
				git_clean = false,
				exclude = {},
				custom = { "^\\.git$", "^\\.direnv$", "^.parcel-cache$", "^node_modules$", "\\.lock$", "\\.lockb$" },
			},

			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = true,
			hijack_unnamed_buffer_when_opening = false,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			git = {
				enable = true,
				ignore = true,
			},
			actions = {
				open_file = {
					resize_window = true,
				},
				expand_all = {
					exclude = { ".git", "node_modules", ",direnv" },
				},
			},
			filesystem_watchers = {
				enable = true,
			},

			renderer = {
				highlight_git = true,
				highlight_opened_files = "none",
				root_folder_label = false,

				indent_markers = {
					enable = false,
				},

				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = false,
					},

					glyphs = {
						default = "󰈚",
						symlink = "",
						folder = {
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
							symlink_open = "",
							arrow_open = "",
							arrow_closed = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			view = {
				float = {
					enable = true,
					open_win_config = function()
						local screen_w = vim.opt.columns:get()
						local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
						local window_w = screen_w * WIDTH_RATIO
						local window_h = screen_h * HEIGHT_RATIO
						local window_w_int = math.floor(window_w)
						local window_h_int = math.floor(window_h)
						local center_x = (screen_w - window_w) / 2
						local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
						return {
							border = "rounded",
							relative = "editor",
							row = center_y,
							col = center_x,
							width = window_w_int,
							height = window_h_int,
						}
					end,
				},
				width = function()
					return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
				end,
			},
		},
		config = function(_, opts)
			require("nvim-tree").setup(opts)

			vim.keymap.set(
				"n",
				"<C-n>",
				"<cmd> NvimTreeToggle<CR>",
				{ noremap = true, silent = true },
				{ desc = "Toggle NvimTree" }
			)
		end,
	},
}
