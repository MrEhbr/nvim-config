return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
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
			local disable_filetypes = { c = true, cpp = true }
			local timeout = 500
			if vim.bo[bufnr].filetype == "php" then
				timeout = 1000
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
			markdown = { "markdownlint", "cbfmt" },
			nix = { "nixpkgs_fmt" },
			proto = { "buf" },
			sql = { "pg_format" },
			php = { "pint" },
			go = { "golines", "goimports", "gofumpt" },

			javascript = { "prettierd", "prettier", stop_after_first = true },
			typestript = { "prettierd", "prettier", stop_after_first = true },
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
					-- "--wrap-after",
					-- "1",
					"--keep-newline",
					-- "--wrap-limit",
					-- "160",
				},
				golines = {
					prepend_args = {
						"-m",
						"180",
						"--reformat-tags",
						"--base-formatter=gofumpt",
					},
				},
				shfmt = {},
			},
		},
	},
}
