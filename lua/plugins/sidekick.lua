return {
	"folke/sidekick.nvim",
	opts = {
		-- add any options here
		cli = {
			mux = {
				backend = "tmux",
				enabled = true,
			},
			nes = {
				enabled = false,
			},
			tools = {
				claude = { cmd = { "claude", "--mcp-config", vim.fn.expand("$HOME/.claude/.mcp.json") } },
			},
		},
	},
	keys = {
		{
			"<M-l>",
			function()
				if require("sidekick").nes_jump_or_apply() then
					return
				end

				if vim.lsp.inline_completion.get() then
					return
				end

				return "<M-l>"
			end,
			mode = { "n", "x", "i", "t" },
			expr = true,
			desc = "Goto/Apply Next Edit Suggestion",
		},
		{
			"<M-a>",
			function()
				require("sidekick.cli").toggle({ filter = { installed = true } })
			end,
			desc = "Sidekick Toggle CLI",
			mode = { "n", "v", "t" },
		},
		{
			"<leader>aa",
			function()
				require("sidekick.cli").select({ filter = { installed = true } })
			end,
			desc = "Sidekick Select CLI",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			desc = "Sidekick Ask Prompt",
			mode = { "n", "v" },
		},
		{
			"<leader>as",
			function()
				require("sidekick.cli").send({ selection = true })
			end,
			mode = { "v" },
			desc = "Sidekick Send Visual Selection",
		},
		{
			"<M-.>",
			function()
				require("sidekick.cli").focus()
			end,
			mode = { "n", "x", "i", "t" },
			desc = "Sidekick Switch Focus",
		},
	},
}
