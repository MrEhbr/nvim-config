return {
	"zk-org/zk-nvim",
	config = function()
		require("zk").setup({
			picker = "snacks_picker",
			picker_options = {
				snacks_picker = {
					layout = {
						preset = "ivy",
					},
				},
			},
			lsp = {
				config = {
					cmd = { "zk", "lsp" },
					name = "zk",
				},

				auto_attach = {
					enabled = true,
					filetypes = { "markdown" },
				},
			},
		})

		local keymaps = {
			{
				mode = "n",
				lhs = "<leader>zz",
				rhs = function()
					local root_dir = vim.fn.getcwd() -- Use the current working directory
					local dirs = {}
					for _, dir in ipairs(vim.fn.glob(root_dir .. "/*", 1, 1)) do
						if vim.fn.isdirectory(dir) == 1 then
							table.insert(dirs, vim.fn.fnamemodify(dir, ":t"))
						end
					end

					vim.ui.select(dirs, { prompt = "Select directory:" }, function(selected_dir)
						if selected_dir then
							local title = vim.fn.input("Title: ")
							require("zk.commands").get("ZkNew")({ title = title, dir = root_dir .. "/" .. selected_dir })
						end
					end)
				end,
				desc = "Create a note in a selected directory",
			},
			{
				mode = "n",
				lhs = "<leader>zn",
				rhs = function()
					local dir = vim.fn.expand("%:p:h")
					local title = vim.fn.input("Title: ")
					require("zk.commands").get("ZkNew")({ dir = dir, title = title })
				end,
				desc = "New note in current buffer's directory",
			},
			{
				mode = "v",
				lhs = "<leader>znt",
				rhs = function()
					local dir = vim.fn.expand("%:p:h")
					require("zk.commands").get("ZkNewFromTitleSelection")({ dir = dir })
				end,
				desc = "New note with selection as title",
			},
			{
				mode = "v",
				lhs = "<leader>zc",
				rhs = function()
					local dir = vim.fn.expand("%:p:h")
					local title = vim.fn.input("Title: ")
					require("zk.commands").get("ZkNewFromContentSelection")({ dir = dir, title = title })
				end,
				desc = "New note with selection as content and custom title",
			},
			{
				mode = "n",
				lhs = "<leader>zi",
				rhs = function()
					require("zk.commands").get("ZkInsert")()
				end,
				desc = "Insert a link to a note in the current buffer",
			},
			{
				mode = "n",
				lhs = "<leader>zo",
				rhs = function()
					require("zk.commands").get("ZkNotes")({ sort = { "modified" } })
				end,
				desc = "Open notes sorted by modification date",
			},
		}

		for _, map in ipairs(keymaps) do
			vim.keymap.set(map.mode, map.lhs, map.rhs, { noremap = true, silent = false, desc = map.desc })
		end
	end,
}
