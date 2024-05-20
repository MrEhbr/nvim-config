return {
	"folke/sidekick.nvim",
	opts = {
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
			win = {
				split = {
					width = 85,
				},
			},
			prompts = {
				dir = "{dir}",
			},
			context = {
				dir = function(ctx)
					local Loc = require("sidekick.cli.context.location")
					if not Loc.is_file(ctx.buf) then return end
					local name = vim.api.nvim_buf_get_name(ctx.buf)
					local rel = vim.fs.relpath(ctx.cwd, name)
					local dir = vim.fs.dirname(rel or name)
					return { { { "@", "SidekickLocDelim" }, { dir, "SidekickLocFile" } } }
				end,
			},
		},
	},
	config = function(_, opts)
		vim.g.sidekick_nes = false
		require("sidekick").setup(opts)
	end,
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
