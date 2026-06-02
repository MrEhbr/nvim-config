return {
	"pwntester/octo.nvim",
	cmd = "Octo",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		picker = "snacks",
		enable_builtin = true,
		default_to_projects_v2 = true,
		default_merge_method = "squash",
		suppress_missing_scope = {
			projects_v2 = true,
		},
		mappings = {
			review_diff = {
				-- NOTE: make it easy to switch between files while reviewing diffs
				select_next_entry = { lhs = "J", desc = "move to previous changed file" },
				select_prev_entry = { lhs = "K", desc = "move to next changed file" },
			},
		},
	},
	keys = {
		{ "<leader>O", "", desc = " Octo (GitHub)" },
		{ "<leader>Op", "<CMD>Octo pr list<CR>", desc = "PR list" },
		{ "<leader>OP", "<CMD>Octo pr create<CR>", desc = "PR create" },
		{ "<leader>Os", "<CMD>Octo pr search<CR>", desc = "PR search" },
		{ "<leader>Oi", "<CMD>Octo issue list<CR>", desc = "Issue list" },
		{ "<leader>OI", "<CMD>Octo issue create<CR>", desc = "Issue create" },
		{ "<leader>OS", "<CMD>Octo search<CR>", desc = "Search" },
		{ "<leader>Or", "<CMD>Octo review start<CR>", desc = "Review start" },
		{ "<leader>OR", "<CMD>Octo repo list<CR>", desc = "Repo list" },
		{ "<leader>On", "<CMD>Octo notification list<CR>", desc = "Notifications" },
		{ "<leader>Oa", "<CMD>Octo actions<CR>", desc = "Actions menu" },
	},
}
