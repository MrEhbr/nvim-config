return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
			{
				"s1n7ax/nvim-window-picker", -- for open_with_window_picker keymaps
				version = "2.*",
				config = function()
					require("window-picker").setup({
						hint = "floating-big-letter",
						filter_rules = {
							include_current_win = false,
							autoselect_one = true,
							bo = {
								filetype = { "neo-tree", "neo-tree-popup", "notify" },
								buftype = { "terminal", "quickfix" },
							},
						},
					})
				end,
			},
		},
		lazy = false,
		config = function()
			require("neo-tree").setup({
				close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
				open_files_using_relative_paths = false,
				sort_case_insensitive = false,
				default_component_configs = {
					container = {
						enable_character_fade = true,
					},
					indent = {
						indent_size = 2,
						padding = 1,
						with_markers = true,
						indent_marker = "│",
						last_indent_marker = "└",
						highlight = "NeoTreeIndentMarker",
						with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
						expander_collapsed = "",
						expander_expanded = "",
						expander_highlight = "NeoTreeExpander",
					},
					---@diagnostic disable-next-line: missing-fields
					icon = {
						provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
							if node.type == "file" or node.type == "terminal" then
								local success, web_devicons = pcall(require, "nvim-web-devicons")
								local name = node.type == "terminal" and "terminal" or node.name
								if success then
									local devicon, hl = web_devicons.get_icon(name)
									icon.text = devicon or icon.text
									icon.highlight = hl or icon.highlight
								end
							end
						end,
						default = "*",
						highlight = "NeoTreeFileIcon",
					},
					modified = {
						symbol = "[+]",
						highlight = "NeoTreeModified",
					},
					name = {
						trailing_slash = false,
						use_git_status_colors = true,
						highlight = "NeoTreeFileName",
					},
					git_status = {
						symbols = {
							-- Change type
							added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
							modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
							deleted = "✖", -- this can only be used in the git_status source
							renamed = "󰁕", -- this can only be used in the git_status source
							untracked = "",
							ignored = "",
							unstaged = "󰄱",
							staged = "",
							conflict = "",
						},
					},
					-- If you don't want to use these columns, you can set `enabled = false` for each of them individually
					file_size = {
						enabled = true,
						width = 12,
						required_width = 64,
					},
					type = {
						enabled = true,
						width = 10,
						required_width = 122,
					},
					last_modified = {
						enabled = true,
						width = 20,
						required_width = 88,
						format = "%d %b %Y",
					},
					created = {
						enabled = true,
						width = 20,
						required_width = 110,
						format = "%d %b %Y",
					},
					symlink_target = {
						enabled = false,
						text_format = "→ %s",
					},
				},
				commands = {},
				window = {
					position = "float",
					mapping_options = {
						noremap = true,
						nowait = true,
					},
					mappings = {
						["<space>"] = {
							"toggle_node",
							nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
						},
						["<2-LeftMouse>"] = "open",
						["<cr>"] = "open",
						["<esc>"] = "cancel", -- close preview or floating neo-tree window
						["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
						["l"] = "focus_preview",
						-- ["S"] = "open_split",
						-- ["s"] = "open_vsplit",
						["S"] = "split_with_window_picker",
						["s"] = "vsplit_with_window_picker",
						["t"] = "open_tabnew",
						["w"] = "open_with_window_picker",
						["C"] = "close_node",
						["z"] = "close_all_nodes",
						["a"] = {
							"add",
							config = {
								show_path = "relative", -- "none", "relative", "absolute"
							},
						},
						["A"] = {
							"add_directory",
							config = {
								show_path = "relative", -- "none", "relative", "absolute"
							},
						},
						["d"] = "delete",
						["r"] = "rename",
						["b"] = "rename_basename",
						["y"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["p"] = "paste_from_clipboard",
						["c"] = {
							"copy",
							config = {
								show_path = "relative", -- "none", "relative", "absolute"
							},
						},
						["m"] = {
							"move",
							config = {
								show_path = "relative", -- "none", "relative", "absolute"
							},
						},
						["q"] = "close_window",
						["R"] = "refresh",
						["?"] = "show_help",
						["<"] = "prev_source",
						[">"] = "next_source",
						["i"] = "show_file_details",
					},
				},
				nesting_rules = {},
				filesystem = {
					filtered_items = {
						visible = false, -- when true, they will just be displayed differently than normal items
						hide_dotfiles = true,
						hide_gitignored = true,
						hide_hidden = true, -- only works on Windows for hidden files/directories
						hide_by_name = {
							"node_modules",
						},
						hide_by_pattern = {},
						always_show = {
							".gitignored",
						},
						always_show_by_pattern = {},
						never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
							".git",
							".DS_Store",
							"thumbs.db",
						},
						never_show_by_pattern = {
							".null-ls_*",
						},
					},
					follow_current_file = {
						enabled = true,
						leave_dirs_open = true,
					},
					group_empty_dirs = false,
					hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
					use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
					window = {
						mappings = {
							["<bs>"] = "navigate_up",
							["."] = "set_root",
							["H"] = "toggle_hidden",
							["/"] = "fuzzy_finder",
							["D"] = "fuzzy_finder_directory",
							["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
							-- ["D"] = "fuzzy_sorter_directory",
							["f"] = "filter_on_submit",
							["<c-x>"] = "clear_filter",
							["[g"] = "prev_git_modified",
							["]g"] = "next_git_modified",
							["o"] = {
								"show_help",
								nowait = false,
								config = { title = "Order by", prefix_key = "o" },
							},
							["oc"] = { "order_by_created", nowait = false },
							["od"] = { "order_by_diagnostics", nowait = false },
							["og"] = { "order_by_git_status", nowait = false },
							["om"] = { "order_by_modified", nowait = false },
							["on"] = { "order_by_name", nowait = false },
							["os"] = { "order_by_size", nowait = false },
							["ot"] = { "order_by_type", nowait = false },
							-- ['<key>'] = function(state) ... end,
						},
						fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
							["<down>"] = "move_cursor_down",
							["<C-n>"] = "move_cursor_down",
							["<up>"] = "move_cursor_up",
							["<C-p>"] = "move_cursor_up",
							["<esc>"] = "close",
							-- ['<key>'] = function(state, scroll_padding) ... end,
						},
					},

					commands = {}, -- Add a custom command or override a global one using the same function name
				},
				buffers = {
					follow_current_file = {
						enabled = true,
						leave_dirs_open = false,
					},
					group_empty_dirs = true, -- when true, empty folders will be grouped together
					show_unloaded = true,
					window = {
						mappings = {
							["d"] = "buffer_delete",
							["bd"] = "buffer_delete",
							["<bs>"] = "navigate_up",
							["."] = "set_root",
							["o"] = {
								"show_help",
								nowait = false,
								config = { title = "Order by", prefix_key = "o" },
							},
							["oc"] = { "order_by_created", nowait = false },
							["od"] = { "order_by_diagnostics", nowait = false },
							["om"] = { "order_by_modified", nowait = false },
							["on"] = { "order_by_name", nowait = false },
							["os"] = { "order_by_size", nowait = false },
							["ot"] = { "order_by_type", nowait = false },
						},
					},
				},
				git_status = {
					window = {
						position = "float",
						mappings = {
							["A"] = "git_add_all",
							["gu"] = "git_unstage_file",
							["ga"] = "git_add_file",
							["gr"] = "git_revert_file",
							["gc"] = "git_commit",
							["gp"] = "git_push",
							["gg"] = "git_commit_and_push",
							["o"] = {
								"show_help",
								nowait = false,
								config = { title = "Order by", prefix_key = "o" },
							},
							["oc"] = { "order_by_created", nowait = false },
							["od"] = { "order_by_diagnostics", nowait = false },
							["om"] = { "order_by_modified", nowait = false },
							["on"] = { "order_by_name", nowait = false },
							["os"] = { "order_by_size", nowait = false },
							["ot"] = { "order_by_type", nowait = false },
						},
					},
				},
			})

			vim.keymap.set("n", "<C-n>", "<Cmd>Neotree toggle<CR>")
		end,
	},
}
