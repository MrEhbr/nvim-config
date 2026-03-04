return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufWritePost" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fm",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		notify_on_error = true,
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = function(bufnr)
			if not vim.g.autoformat then
				return false
			end
			local skip = { php = true }
			if skip[vim.bo[bufnr].filetype] then
				return false
			end
			return {
				timeout_ms = 5000,
			}
		end,
		format_after_save = function(bufnr)
			if not vim.g.autoformat then
				return false
			end
			local slow_filetypes = { php = true }
			if not slow_filetypes[vim.bo[bufnr].filetype] then
				return false
			end
			return {}
		end,
		formatters_by_ft = {
			sh = { "shfmt" },
			lua = { "stylua" },
			python = { "black" },
			templ = { "templ" },
			markdown = { "markdownlint", "cbfmt" },
			nix = { "nixpkgs_fmt" },
			proto = { "buf" },
			sql = { "sqruff" },
			php = { "pint" },
			go = { "golines", "goimports", "gofumpt" },
			just = {}, -- disabled: just --fmt adds [private] to _ vars, breaks treesitter

			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			["_"] = { "trim_whitespace" },
			["*"] = { "injected" },
		},
		formatters = {
			sqruff = {
				exit_codes = { 0, 1 },
			},
			golines = {
				prepend_args = {
					"-m",
					"180",
					"--reformat-tags",
					"--base-formatter=gofumpt",
				},
			},
			shfmt = {
				prepend_args = { "-i", "2", "-ci" },
			},
			pint = {
				prepend_args = {
					"--no-interaction",
					"--quiet",
				},
			},
			templ = {
				command = "templ",
				args = { "fmt", "-stdin" },
				stdin = true,
			},
			injected = {
				condition = function(_, ctx)
					-- skip just files: injected triggers just --fmt which adds [private] breaking treesitter
					return ctx.filetype ~= "just"
				end,
				options = {
					ignore_errors = false,
					debug = false,
					lang_to_formatters = {
						sql = { "sqruff" },
					},
					lang_to_ft = {
						sql = "sql",
					},
					lang_to_ext = {
						sql = "sql",
					},
				},
			},
		},
	},
}
