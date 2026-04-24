return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile", "BufWritePost" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				sh = { "shellcheck" },
				bash = { "shellcheck" },
				dockerfile = { "hadolint" },
				yaml = { "actionlint" },
			}

			local actionlint = lint.linters.actionlint
			actionlint.condition = function(ctx)
				return ctx.filename:match("%.github/workflows/.*%.ya?ml$") ~= nil
			end

			local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
				group = group,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>ll", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},
}
