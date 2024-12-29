return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	config = function()
		local builtins = require("null-ls").builtins
		local sources = {
			-- Web Development
			builtins.formatting.prettierd.with({
				filetypes = { "svelte" },
			}),
			builtins.formatting.rustywind.with({
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
					"html",
					"templ",
				},
			}),
			-- Shell
			builtins.formatting.shfmt.with({
				-- https://github.com/mvdan/sh/blob/master/cmd/shfmt/shfmt.1.scd
				extra_args = { "-i", "2", "-ci" },
			}),
			builtins.diagnostics.fish,

			-- Golang
			builtins.formatting.golines.with({
				extra_args = { "-m", "180", "--reformat-tags", "--base-formatter='gofumpt -extra'" },
			}),

			builtins.formatting.goimports,
			builtins.formatting.goimports_reviser,
			-- builtins.diagnostics.golangci_lint,
			builtins.code_actions.gomodifytags,
			-- PHP
			builtins.formatting.pint.with({
				command = "pint",
			}),

			-- SQL
			builtins.formatting.pg_format.with({
				extra_args = {
					"--keyword-case",
					"2",
					"--type-case",
					"0",
					"--spaces",
					"4",
					"--no-space-function",
					"--wrap-after",
					"1",
					-- "--wrap-limit",
					-- "160",
				},
			}),
			-- protobuf
			builtins.formatting.buf,
			-- Nix
			builtins.formatting.nixpkgs_fmt,

			-- Python
			builtins.formatting.black,
			-- HTML
			builtins.formatting.tidy.with({
				filetypes = { "html", "xml", "svg" },
			}),
			-- Lua
			builtins.formatting.stylua,

			-- Markdown
			builtins.formatting.cbfmt,
			builtins.formatting.markdownlint,
		}

		local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
		local event = "BufWritePre" -- or "BufWritePost"
		local async = event == "BufWritePost"

		require("null-ls").setup({
			debug = true,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
					vim.api.nvim_create_autocmd(event, {
						group = group,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, async = async })
						end,
					})
				end
			end,
			sources = sources,
		})
	end,
}
