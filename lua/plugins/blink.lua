return {
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "mikavilpas/blink-ripgrep.nvim", version = "*" },
		},
		version = "1.*",
		opts = {
			keymap = { preset = "enter" },
			fuzzy = { implementation = "prefer_rust_with_warning" },
			cmdline = {
				completion = {
					menu = {
						auto_show = function(ctx)
							return ctx.mode == "cmdline" and string.len(ctx.line) > 3
						end,
					},
				},
				keymap = {
					preset = "enter",
					["<Tab>"] = { "accept" },
					["<CR>"] = { "accept", "fallback" },
				},
				sources = function()
					local type = vim.fn.getcmdtype()
					-- Search forward and backward
					if type == "/" or type == "?" then
						return {}
					end
					-- Commands
					if type == ":" or type == "@" then
						return { "cmdline" }
					end
					return {}
				end,
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer", "ripgrep" },
				per_filetype = {
					sql = { "buffer" },
				},
				providers = {
					cmdline = {
						min_keyword_length = function(ctx)
							if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
								return 3
							end
							return 0
						end,
					},

					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},

					ripgrep = {
						name = "Ripgrep",
						module = "blink-ripgrep",
						async = true,
						score_offset = -5,
						opts = {
							prefix_min_len = 3,
							backend = { use = "gitgrep-or-ripgrep" },
						},
					},
				},
			},
			signature = {
				enabled = true,
				window = {
					show_documentation = false,
					border = "rounded",
				},
			},
			completion = {
				menu = {
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", gap = 1 },
							{ "kind" },
						},
					},
					auto_show = function(ctx)
						return ctx.mode ~= "cmdline"
					end,
					border = "rounded",
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					window = {
						min_width = 10,
						max_width = 60,
						max_height = 20,
						border = "rounded",
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
