return {
	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saghen/blink.compat",
			-- { "MattiasMTS/cmp-dbee", ft = "sql", opts = {} },
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		version = "1.*",
		opts = {
			appearance = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = true,
				-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},
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
						return { "buffer" }
					end
					-- Commands
					if type == ":" or type == "@" then
						return { "cmdline" }
					end
					return {}
				end,
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				-- per_filetype = { sql = { "dbee" } },
				providers = {
					cmdline = {
						min_keyword_length = function(ctx)
							if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
								return 3
							end
							return 0
						end,
					},

					-- dbee = {
					-- 	name = "DB",
					-- 	module = "blink.compat.source",
					-- 	opts = { cmp_name = "cmp-dbee" },
					-- 	transform_items = function(_, items)
					-- 		return vim.tbl_filter(function(item)
					-- 			return item.kind ~= require("blink.cmp.types").CompletionItemKind.Keyword
					-- 		end, items)
					-- 	end,
					-- },
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
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
		opts_extend = { "sources.default", "sources.completion.enabled_providers" },
	},
}
