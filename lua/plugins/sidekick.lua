return {
	"folke/sidekick.nvim",
	opts = {
		-- add any options here
		cli = {
			mux = {
				backend = "tmux",
				enabled = false,
			},
			nes = {
				enabled = false,
			},
			tools = {
				claude = { cmd = { "claude", "--mcp-config", vim.fn.expand("$HOME/.claude/.mcp.json") } },
			},
		},
	},
	config = function(_, opts)
		vim.g.sidekick_nes = false
		require("sidekick").setup(opts)
	end,
	keys = {
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
