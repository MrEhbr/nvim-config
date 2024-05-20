return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
		config = function()
			local parsers = {
				"query",
				"markdown",
				"markdown_inline",
				"lua",
				"go",
				"rust",
				"php",
				"sql",
				"javascript",
				"typescript",
				"svelte",
				"fish",
				"vim",
				"dockerfile",
				"proto",
				"make",
				"templ",
				"html",
				"hurl",
				"regex",
				"bash",
				"diff",
				"yaml",
				"json",
				"just",
				"dart",
			}

			local installed = require("nvim-treesitter").get_installed()
			local installed_set = {}
			for _, lang in ipairs(installed) do
				installed_set[lang] = true
			end

			local missing = {}
			for _, lang in ipairs(parsers) do
				if not installed_set[lang] then
					table.insert(missing, lang)
				end
			end

			if #missing > 0 then
				require("nvim-treesitter").install(missing)
			end

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ok = pcall(vim.treesitter.start, args.buf)
					if ok then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "BufReadPost",
		config = function()
			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")

			require("nvim-treesitter-textobjects").setup({
				move = { set_jumps = true },
			})

			-- Move to next/prev function
			vim.keymap.set({ "n", "x", "o" }, "]f", function()
				move.goto_next_start("@function.outer", "textobjects")
			end, { desc = "Next function start" })
			vim.keymap.set({ "n", "x", "o" }, "[f", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end, { desc = "Prev function start" })
			vim.keymap.set({ "n", "x", "o" }, "]F", function()
				move.goto_next_end("@function.outer", "textobjects")
			end, { desc = "Next function end" })
			vim.keymap.set({ "n", "x", "o" }, "[F", function()
				move.goto_previous_end("@function.outer", "textobjects")
			end, { desc = "Prev function end" })

			-- Move to next/prev class/type
			vim.keymap.set({ "n", "x", "o" }, "]t", function()
				move.goto_next_start("@class.outer", "textobjects")
			end, { desc = "Next class/type start" })
			vim.keymap.set({ "n", "x", "o" }, "[t", function()
				move.goto_previous_start("@class.outer", "textobjects")
			end, { desc = "Prev class/type start" })

			-- Move to next/prev parameter
			vim.keymap.set({ "n", "x", "o" }, "]a", function()
				move.goto_next_start("@parameter.inner", "textobjects")
			end, { desc = "Next parameter" })
			vim.keymap.set({ "n", "x", "o" }, "[a", function()
				move.goto_previous_start("@parameter.inner", "textobjects")
			end, { desc = "Prev parameter" })

			-- Swap parameters
			vim.keymap.set("n", "<leader>sa", function()
				swap.swap_next("@parameter.inner")
			end, { desc = "Swap next parameter" })
			vim.keymap.set("n", "<leader>sA", function()
				swap.swap_previous("@parameter.inner")
			end, { desc = "Swap prev parameter" })
		end,
	},
}
