return {
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
		keys = {
			{ "<M-c>", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat" },
		},
		cmd = {
			"CopilotChat",
			"CopilotChatToggle",
			"CopilotChatCommit",
			"CopilotChatExplain",
			"CopilotChatReview",
			"CopilotChatFix",
			"CopilotChatOptimize",
			"CopilotChatDocs",
			"CopilotChatTests",
		},
		opts = {
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
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)
		end,
	},
}
