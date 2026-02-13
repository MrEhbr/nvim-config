return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
		config = function()
			---@param buf integer
			---@param language string
			local function treesitter_try_attach(buf, language)
				if not vim.treesitter.language.add(language) then
					return
				end
				vim.treesitter.start(buf, language)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end

			local available_parsers = require("nvim-treesitter").get_available()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf, filetype = args.buf, args.match
					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end

					local installed_parsers = require("nvim-treesitter").get_installed("parsers")

					if vim.tbl_contains(installed_parsers, language) then
						treesitter_try_attach(buf, language)
					elseif vim.tbl_contains(available_parsers, language) then
						require("nvim-treesitter").install(language):await(function()
							treesitter_try_attach(buf, language)
						end)
					else
						treesitter_try_attach(buf, language)
					end
				end,
			})

			-- ensure basic parser are installed
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
			require("nvim-treesitter").install(parsers)
		end,
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects (using the `main` branch)
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
	{
		"ravsii/tree-sitter-d2",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		version = "*",
		build = "make nvim-install",
	},
}
