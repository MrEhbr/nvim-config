return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
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
		notify_on_error = false,
		format_on_save = function(bufnr)
			if not vim.g.autoformat then
				return false
			end
			local disable_filetypes = { c = true, cpp = true }
			local timeout = 5000
			local timeouts = { php = 3000 }
			if timeouts[vim.bo[bufnr].filetype] then
				timeout = timeouts[vim.bo[bufnr].filetype]
			end
			return {
				timeout_ms = timeout,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
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
			pg_format = {
				prepend_args = {
					"--keyword-case",
					"2",
					"--type-case",
					"2",
					"--spaces",
					"4",
					"--no-space-function",
					"--nogrouping",
					"--keep-newline",
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
					debug = true,
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
