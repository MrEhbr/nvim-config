local SYSTEM_PROMPT = require("plugins.codecompanion.prompts").SYSTEM_PROMPT

return {
	enabled = true,
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"MeanderingProgrammer/render-markdown.nvim",
		"j-hui/fidget.nvim",
	},
	opts = {
		-- adapters = {
		-- copilot = function()
		-- 	return require("codecompanion.adapters").extend("copilot", {
		-- 		schema = {
		-- 			model = {
		-- 				default = "claude-3.7-sonnet",
		-- 			},
		-- 		},
		-- 	})
		-- end,
		-- },
		strategies = {
			chat = {
				adapter = "copilot",
				tools = {
					groups = {
						["all_in_one"] = {
							description = "Everything but the kitchen sink (we're working on that)",
							system_prompt = "You are an agent, please keep going until the user's query is completely resolved, before ending your turn and yielding back to the user. Only terminate your turn when you are sure that the problem is solved. If you are not sure about file content or codebase structure pertaining to the user's request, use your tools to read files and gather the relevant information: do NOT guess or make up an answer. You MUST plan extensively before each function call, and reflect extensively on the outcomes of the previous function calls. DO NOT do this entire process by making function calls only, as this can impair your ability to solve the problem and think insightfully.",
							tools = {
								"cmd_runner",
								"editor",
								"files",
								"mcp",
							},
						},
					},
				},
				roles = {
					llm = function(adapter)
						local model_name = ""
						if adapter.schema and adapter.schema.model and adapter.schema.model.default then
							local model = adapter.schema.model.default
							if type(model) == "function" then
								model = model(adapter)
							end
							model_name = "(" .. model .. ")"
						end
						return "  " .. adapter.formatted_name .. model_name
					end,
					user = " User",
				},
				slash_commands = {
					["buffer"] = {
						callback = "strategies.chat.slash_commands.buffer",
						description = "Insert open buffers",
						opts = {
							contains_code = true,
							provider = "snacks",
						},
					},
					["file"] = {
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
					close = {
						modes = {
							n = "q",
						},
						index = 3,
						callback = "keymaps.close",
						description = "Close Chat",
					},
					stop = {
						modes = {
							n = "<C-c>",
						},
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
				-- Change to true to show the current model
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
			system_prompt = SYSTEM_PROMPT,
		},
		prompt_library = require("plugins.codecompanion.prompts").PROMPT_LIBRARY,
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
		require("plugins.codecompanion.spinner"):init()
		require("plugins.codecompanion.fidget-spinner"):init()

		local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

		vim.api.nvim_create_autocmd({ "User" }, {
			pattern = "CodeCompanionInlineFinished",
			group = group,
			callback = function(request)
				vim.lsp.buf.format({ bufnr = request.buf })
			end,
		})

		require("codecompanion").setup(opts)
	end,
}
