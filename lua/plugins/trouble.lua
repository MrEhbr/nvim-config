return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	enabled = true,
	event = "LspAttach",
	cmd = { "Trouble" },
	opts = {
		preview = {
			scratch = false,
		},
	},
	keys = {
		{
			"<leader>qq",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>qd",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>ql",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
		{
			"<leader>qr",
			"<cmd>Trouble lsp_references toggle<cr>",
			desc = "LSP references (via Trouble plugin)",
		},
		{
			"<M-j>",
			"<cmd>Trouble next jump=true skip_groups=true<cr>",
			desc = "Next Trouble item",
		},
		{
			"<M-k>",
			"<cmd>Trouble prev jump=true skip_groups=true<cr>",
			desc = "Previous Trouble item",
		},
	},
}
