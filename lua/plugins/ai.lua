---@type NvPluginSpec[]
local plugins = {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<M-l>",
						accept_word = "<M-w>",
						accept_line = "<M-;>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken",
		config = function()
			local opts = {
				debug = false,
				model = "gpt-4o",
				context = "buffers",
				chat_autocomplete = true,
				window = {
					layout = "float",
					width = 0.8,
					height = 0.8,
					relative = "editor",
					border = "single",
				},
				mappings = {
					complete = {
						insert = "",
					},
				},
			}
			require("CopilotChat").setup(opts)

			vim.keymap.set("n", "<M-c>", function()
				require("CopilotChat").toggle()
			end, { desc = "CopilotChat - Toggle" })
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions" },
		config = function()
			require("chatgpt").setup({
				api_key_cmd = "op read op://Personal/OpenAI/credential --no-newline",
				openai_params = {
					model = "gpt-4o",
					frequency_penalty = 0,
					presence_penalty = 0,
					max_tokens = 1000,
					temperature = 0,
					top_p = 1,
					n = 1,
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
}

return plugins
