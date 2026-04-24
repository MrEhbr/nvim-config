return {
	{
		"folke/persistence.nvim",
		lazy = false,
		opts = {
			-- Per-git-branch sessions (default). Branch name is appended to the
			-- session filename unless on main/master, with fallback to a
			-- branchless session when a branch-specific one doesn't exist.
			branch = true,
		},
		init = function()
			vim.api.nvim_create_autocmd("StdinReadPre", {
				group = vim.api.nvim_create_augroup("persistence-stdin", { clear = true }),
				callback = function()
					vim.g.started_with_stdin = true
				end,
			})

			vim.api.nvim_create_autocmd("VimEnter", {
				group = vim.api.nvim_create_augroup("persistence-autoload", { clear = true }),
				nested = true,
				callback = function()
					if vim.fn.argc(-1) == 0 and vim.g.started_with_stdin ~= true then
						require("persistence").load()
					end
				end,
			})
		end,
	},
}
