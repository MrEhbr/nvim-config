return {
	-- Dressing.nvim Configuration with nui backend
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			input = {
				enabled = true,
				default_prompt = "➤ ",
				prompt_align = "center",
				insert_only = false,
				start_in_insert = true,
				border = "rounded",
				relative = "editor",
				prefer_width = 40,
				width = nil,
				max_width = { 140, 0.9 },
				min_width = { 20, 0.2 },
				win_options = {
					winblend = 10,
					wrap = false,
				},
				mappings = {
					n = {
						["q"] = "Close",
						["<Esc>"] = "Close",
					},
					i = {
						["<C-c>"] = "Close",
						["<Esc>"] = "Close",
						["<CR>"] = "Confirm",
						["<Up>"] = "HistoryPrev",
						["<Down>"] = "HistoryNext",
					},
				},
			},
			select = {
				enabled = true,
				backend = { "telescope", "fzf_lua", "fzf", "nui" },
				telescope = {
					theme = "dropdown",
				},
				nui = {
					position = "50%",
					size = nil,
					relative = "editor",
					border = {
						style = "rounded",
						padding = { 1, 1 },
					},
					max_width = 80,
					max_height = 40,
					min_width = 40,
					min_height = 10,
					win_options = {
						winblend = 10,
					},
				},
				get_config = function(opts)
					if opts and opts.kind == "codeaction" then
						return {
							backend = "nui",
							nui = {
								position = {
									row = 1,
									col = 0,
								},
								relative = "cursor",
								border = {
									style = "rounded",
								},
								max_width = 50,
								max_height = 20,
								min_width = 20,
								min_height = 1,
								win_options = {
									winblend = 0,
								},
							},
						}
					end
				end,
			},
		},
	},

	-- Noice.nvim Configuration remains the same...
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				progress = {
					enabled = true,
					format = "lsp_progress",
					format_done = "lsp_progress_done",
					throttle = 1000 / 30,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					enabled = true,
					view = "hover",
					opts = {},
				},
				signature = {
					enabled = true,
					auto_open = {
						enabled = true,
						trigger = true,
						throttle = 50,
					},
					view = "hover",
					opts = {},
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
				lsp_doc_border = true,
			},
			messages = {
				enabled = true,
				view = "mini",
				view_error = "mini",
				view_warn = "mini",
				view_history = "split",
				view_search = "virtualtext",
			},
			notify = {
				enabled = true,
				view = "notify",
			},
			views = {
				cmdline_popup = {
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winblend = 10,
					},
				},
				split = {
					win_options = {
						wrap = true,
						linebreak = true,
						spell = false,
						signcolumn = "no",
						foldcolumn = "0",
						cursorline = false,
						winhighlight = {
							Normal = "Normal",
							FloatBorder = "DiagnosticInfo",
						},
					},
				},
				hover = {
					border = {
						style = "rounded",
					},
					position = { row = 2, col = 2 },
					win_options = {
						winblend = 0,
					},
				},
			},
			routes = {
				{
					filter = { event = "msg_show", min_height = 20 },
					view = "split",
				},
			},
		},
		config = function(_, opts)
			require("noice").setup(opts)
			vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })
		end,
	},
}
