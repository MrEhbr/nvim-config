local function format_llm_role(adapter)
	local default = adapter and adapter.schema and adapter.schema.model and adapter.schema.model.default
	if type(default) == "function" then
		default = default(adapter)
	end
	local model_suffix = default and ("(" .. default .. ")") or ""
	return "  " .. adapter.formatted_name .. model_suffix
end

return {
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = "bun install -g mcp-hub@latest",
		config = function()
			require("mcphub").setup({})
		end,
	},
	{
		enabled = true,
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"MeanderingProgrammer/render-markdown.nvim",
			"ravitemer/codecompanion-history.nvim",
		},
		opts = {
			extensions = {
				history = {
					enabled = true,
					opts = {
						picker = "snacks",
					},
				},
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						make_tools = true,
						show_server_tools_in_chat = true,
						add_mcp_prefix_to_tool_names = false,
						show_result_in_chat = true,
						format_tool = nil,
						make_vars = true,
						make_slash_commands = true,
					},
				},
			},
			memory = {
				opts = {
					chat = {
						enabled = true,
					},
				},
			},
			strategies = {
				chat = {
					adapter = "copilot",
					roles = {
						llm = format_llm_role,
						user = " User",
					},
					slash_commands = {
						buffer = {
							callback = "strategies.chat.slash_commands.buffer",
							description = "Insert open buffers",
							opts = {
								contains_code = true,
								provider = "snacks",
							},
						},
						file = {
							callback = "strategies.chat.slash_commands.file",
							description = "Insert a file",
							opts = {
								contains_code = true,
								max_lines = 1000,
								provider = "snacks",
							},
						},
					},
					keymaps = {
						send = {
							callback = function(chat)
								vim.cmd("stopinsert")
								chat:submit()
							end,
							index = 1,
							description = "Send",
						},
						stop = {
							modes = { n = "<C-c>" },
							index = 4,
							callback = "keymaps.stop",
							description = "Stop Request",
						},
					},
				},
				inline = { adapter = "copilot" },
				agent = { adapter = "copilot" },
			},
			inline = {
				layout = "horizontal", -- vertical|horizontal|buffer
			},
			display = {
				chat = {
					show_settings = true,
					window = {
						layout = "vertical", -- float|vertical|horizontal|buffer
					},
				},
				diff = {
					enabled = true,
				},
			},
			opts = {
				log_level = "DEBUG",
			},
		},
		keys = {
			-- Recommend setup
			{
				"<leader>ap",
				"<cmd>CodeCompanionActions<cr>",
				desc = "Code Companion - Prompt Actions",
			},
			{
				"<M-a>",
				function()
					vim.cmd("CodeCompanionChat Toggle")
				end,
				desc = "Code Companion - Toggle",
				mode = { "n", "v" },
			},
			-- Some common usages with visual mode
			{
				"<leader>ae",
				"<cmd>CodeCompanion /explain<cr>",
				desc = "Code Companion - Explain code",
				mode = "v",
			},
			{
				"<leader>af",
				"<cmd>CodeCompanion /fix<cr>",
				desc = "Code Companion - Fix code",
				mode = "v",
			},
			{
				"<leader>al",
				"<cmd>CodeCompanion /lsp<cr>",
				desc = "Code Companion - Explain LSP diagnostic",
				mode = { "n", "v" },
			},
			{
				"<leader>at",
				"<cmd>CodeCompanion /tests<cr>",
				desc = "Code Companion - Generate unit test",
				mode = "v",
			},
			{
				"<leader>am",
				"<cmd>CodeCompanion /commit<cr>",
				desc = "Code Companion - Git commit message",
			},
			-- Custom prompts
			{
				"<leader>aM",
				"<cmd>CodeCompanion /staged-commit<cr>",
				desc = "Code Companion - Git commit message (staged)",
			},
			{
				"<leader>ad",
				"<cmd>CodeCompanion /inline-doc<cr>",
				desc = "Code Companion - Inline document code",
				mode = "v",
			},
			{
				"<leader>aD",
				"<cmd>CodeCompanion /doc<cr>",
				desc = "Code Companion - Document code",
				mode = "v",
			},
			{
				"<leader>ar",
				"<cmd>CodeCompanion /refactor<cr>",
				desc = "Code Companion - Refactor code",
				mode = "v",
			},
			{
				"<leader>aR",
				"<cmd>CodeCompanion /review<cr>",
				desc = "Code Companion - Review code",
				mode = "v",
			},
			{
				"<leader>an",
				"<cmd>CodeCompanion /naming<cr>",
				desc = "Code Companion - Better naming",
				mode = "v",
			},
			-- Quick chat
			{
				"<leader>aq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						vim.cmd("CodeCompanion " .. input)
					end
				end,
				desc = "Code Companion - Quick chat",
			},
		},
		config = function(_, opts)
			require("config.codecompanion.spinner"):init()

			require("codecompanion").setup(opts)
		end,
	},
}
