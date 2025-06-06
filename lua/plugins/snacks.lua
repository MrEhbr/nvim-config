local layout = {
	box = "horizontal",
	backdrop = false,
	width = 0.9,
	min_width = 120,
	height = 0.8,
	{
		box = "vertical",
		border = "rounded",
		title = "{title} {live} {flags}",
		{ win = "input", height = 1, border = "bottom" },
		{ win = "list", border = "none" },
	},
	{ win = "preview", title = "{preview}", border = "rounded", width = 0.6 },
}

local exclude = {
	"**/mocks/*",
	"**/node_modules/*",
	"**/.yarn/cache/*",
	"**/.yarn/releases/*",
	"**/.pnpm-store/*",
}

local function filter_exclude(item, filter)
	for _, pattern in ipairs(exclude) do
		return not (vim.fn.match(item.file, pattern) >= 0)
	end
	return true
end

return {
	priority = 1000,
	lazy = false,
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		input = { enabled = true },
		image = { enabled = true, force = true },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		scope = { enabled = true },
		dim = { enabled = true },
		statuscolumn = { enabled = false },
		words = { enabled = true },
		explorer = {
			enabled = true,
			replace_netrw = true,
		},
		indent = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		scratch = {
			ft = function()
				return "markdown"
			end,
		},
		picker = {
			exclude = exclude,
			ui_select = true,
			formatters = {
				file = { filename_first = true },
				selected = { show_always = true },
			},
			icons = {
				ui = {
					selected = "▌ ",
					unselected = "  ",
				},
			},
			actions = require("config.snacks").actions,
			enabled = true,
			sources = {
				explorer = {
					supports_live = false,
					auto_close = false,
					hidden = true,
					layout = {
						layout = {
							backdrop = false,
							width = 60,
							min_width = 50,
							height = 0,
							position = "right",
							border = "right",
							box = "vertical",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
						},
					},
					win = {
						input = {
							keys = {},
						},
						list = {
							keys = {
								["<c-n>"] = "close",
								["<Esc>"] = { "close", mode = { "n", "i" } },
								["Z"] = "explorer_close_all",
								["v"] = "edit_vsplit",
								["s"] = "edit_split",
								["y"] = "copy_file_path",
								["f"] = "search_in_directory",
								["F"] = "search_in_directory_case_sensitive",
								["D"] = "diff",
								["{"] = "focus_next_folder",
								["}"] = "focus_prev_folder",
							},
						},
					},
				},
				files = {
					hidden = true,
					ignored = true,
					layout = { layout = layout },
					exclude = exclude,
				},
				recent = {
					exclude = exclude,
					layout = { layout = layout },
				},
				grep = {
					exclude = exclude,
					layout = { layout = layout },
				},

				lsp_implementations = {
					layout = { layout = layout },
					filter = { filter = filter_exclude },
				},
				lsp_references = {
					layout = { layout = layout },
					filter = { filter = filter_exclude },
				},
				lsp_definitions = {
					layout = { layout = layout },
					filter = { filter = filter_exclude },
				},
			},
			win = {
				input = {
					keys = {
						["<C-q>"] = { "qflist_trouble", mode = { "i", "n" } },
					},
				},
			},
		},
		dashboard = {
			preset = {
				pick = nil,
				---@type snacks.dashboard.Item[]
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = "<leader>ff" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = "<leader>fg",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = "<leader>fo",
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
		styles = {
			input = { relative = "cursor", row = -3, col = 0 },
			zen = {
				width = 0.95, -- 95% of the screen width
			},
			explorer = {},
		},
	},
	keys = {
		-- Top Pickers & Explorer
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>nh",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		{
			"<C-n>",
			function()
				Snacks.explorer({
					git_status = true,
					git_untracked = true,
					exclude = { "node_modules", "coverage" },
					auto_close = true,
					follow_file = true,
					focus = "list",
					diagnostics_open = true,
				})
			end,
			desc = "File Explorer",
		},
		-- find
		{
			"<leader>ff",
			function()
				Snacks.picker.files({ filter = { cwd = true } })
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep({ filter = { cwd = true } })
			end,
			desc = "Find Grep",
		},
		{
			"<leader>fo",
			function()
				Snacks.picker.recent({ filter = { cwd = true } })
			end,
			desc = "Recent",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.lines()
			end,
			desc = "Find in current buffer",
		},
		-- git
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
		-- search
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		{
			"<leader>uh",
			function()
				Snacks.picker.undo({
					win = {
						input = {
							keys = {
								["<C-y>"] = { "yank_add", mode = { "n", "i" } },
								["<C-d>"] = { "yank_del", mode = { "n", "i" } },
							},
						},
					},
				})
			end,
			desc = "Undo History",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gi",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"<leader>ld",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>lw",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},

		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle.inlay_hints():map("<leader>uH")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")

				vim.api.nvim_create_user_command("Zen", Snacks.zen.zen, { desc = "Toggle Zen Mode" })
			end,
		})
	end,
}
