return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
	},
	opts = function()
		return {
			defaults = {
				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				prompt_prefix = "❯ ",
				selection_caret = "❯ ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				file_ignore_patterns = { "node_modules", "\\.git" },
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				path_display = { "truncate" },
				winblend = 0,
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				-- Developer configurations: Not meant for general override
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				mappings = {
					n = { ["q"] = require("telescope.actions").close },
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
			},

			extensions_list = { "fzf", "live_grep_args" },
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},

				live_grep_args = {
					auto_quoting = true,
					mappings = {
						i = {
							["<C-k>"] = function(...)
								require("telescope-live-grep-args.actions").quote_prompt()(...)
							end,
							["<C-i>"] = function(...)
								require("telescope-live-grep-args.actions").quote_prompt({
									postfix = " --iglob ",
								})(...)
							end,
							["<C-t>"] = function(...)
								require("telescope-live-grep-args.actions").quote_prompt({
									postfix = " -t",
								})(...)
							end,
							["<C-a>"] = function(...)
								require("telescope-live-grep-args.actions").quote_prompt({
									postfix = " --hidden --no-ignore",
								})(...)
							end,
						},
					},
				},
			},
		}
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
		for _, ext in ipairs(opts.extensions_list) do
			require("telescope").load_extension(ext)
		end
		local nmap = function(keys, func, desc)
			vim.keymap.set("n", keys, func, {
				desc = desc,
			})
		end

		nmap("<leader>ff", function()
			require("telescope.builtin").find_files()
		end, "[f]ind [f]iles")
		nmap("<leader>fa", function()
			require("telescope.builtin").find_files({
				follow = true,
				no_ignore = true,
				hidden = true,
			})
		end, "[f]ind [a]ll")
		nmap("<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<CR>", "[f]ind In [c]urrent Buffer")
		nmap("<leader>fo", function()
			require("telescope.builtin").oldfiles({
				cwd_only = true,
				tiebreak = function(current_entry, existing_entry, _)
					return current_entry.index < existing_entry.index
				end,
			})
		end, "[f]ind [o]ldfiles")
		nmap("<leader>fg", function()
			require("telescope").extensions.live_grep_args.live_grep_args()
		end, "[f]ind [g]rep")
		nmap("<leader>fw", function()
			require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
		end, "[f]ind [w]ord With Grep")
		nmap("<leader>gc", "<cmd>Telescope git_commits<CR>", "[g]it [c]ommits")
		nmap("<leader>gs", "<cmd>Telescope git_status<CR>", "[g]it [s]tatus")
		nmap("<leader>gb", "<cmd>Telescope git_branches<CR>", "[g]it [b]ranches")

		-- nmap("<leader>ds", function()
		-- 	require("telescope").extensions.dap.configurations({
		-- 		language_filter = function(lang)
		-- 			if lang == "dlv" and vim.bo.filetype == "go" then
		-- 				return true
		-- 			end
		-- 			return lang == vim.bo.filetype
		-- 		end,
		-- 	})
		-- end, "Dap configurations")
	end,
}
