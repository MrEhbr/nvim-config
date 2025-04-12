-- Trash the target
local function trash(state)
	local node = state.tree:get_node()
	if node.type == "message" then
		return
	end
	local _, name = require("neo-tree.utils").split_path(node.path)
	local msg = string.format("Are you sure you want to trash '%s'?", name)
	inputs.confirm(msg, function(confirmed)
		if not confirmed then
			return
		end
		vim.api.nvim_command("silent !trash -F " .. node.path)
		require("neo-tree.sources.manager").refresh(state)
	end)
end

-- Trash the selections (visual mode)
local function trash_visual(state, selected_nodes)
	local paths_to_trash = {}
	for _, node in ipairs(selected_nodes) do
		if node.type ~= "message" then
			table.insert(paths_to_trash, node.path)
		end
	end
	local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
	inputs.confirm(msg, function(confirmed)
		if not confirmed then
			return
		end
		for _, path in ipairs(paths_to_trash) do
			vim.api.nvim_command("silent !trash -F " .. path)
		end
		require("neo-tree.sources.manager").refresh(state)
	end)
end

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		keys = {
			{
				"<C-n>",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd(), position = "left" })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"s1n7ax/nvim-window-picker",
				version = "2.*",
				config = function()
					require("window-picker").setup({
						hint = "floating-big-letter",
						filter_rules = {
							include_current_win = false,
							autoselect_one = true,
							bo = {
								filetype = { "neo-tree", "neo-tree-popup", "notify" },
								buftype = { "terminal", "quickfix" },
							},
						},
					})
				end,
			},
		},

		cmd = "Neotree",
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
			-- because `cwd` is not set up properly.
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
				desc = "Start Neo-tree with directory",
				once = true,
				callback = function()
					if package.loaded["neo-tree"] then
						return
					else
						local stats = vim.uv.fs_stat(vim.fn.argv(0))
						if stats and stats.type == "directory" then
							require("neo-tree")
						end
					end
				end,
			})
		end,
		opts = {
			sources = { "filesystem", "buffers", "git_status" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				auto_expand_width = true,
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
					["<space>"] = "none",
					["Y"] = {
						function(state)
							local node = state.tree:get_node()
							local path = vim.fn.fnamemodify(node:get_id(), ":.")
							vim.fn.setreg("+", path, "c")
							vim.notify("Copied path to clipboard: " .. path)
						end,
						desc = "Copy Path to Clipboard",
					},
					["P"] = { "toggle_preview", config = { use_float = false } },
					["<C-w>"] = "close_node",
					["o"] = "system_open",
					["z"] = "noop",
				},
			},
			commands = {
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.fn.jobstart({ "open", path }, { detach = true })
				end,
				trash = trash,
				trash_visual = trash_visual,
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				git_status = {
					symbols = {
						unstaged = "󰄱",
						staged = "󰱒",
					},
				},
			},
		},
		config = function(_, opts)
			local function on_move(data)
				Snacks.rename.on_rename_file(data.source, data.destination)
			end

			local events = require("neo-tree.events")
			opts.event_handlers = opts.event_handlers or {}
			vim.list_extend(opts.event_handlers, {
				{ event = events.FILE_MOVED, handler = on_move },
				{ event = events.FILE_RENAMED, handler = on_move },
				{
					event = "file_open_requested",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			})
			require("neo-tree").setup(opts)
			vim.api.nvim_create_autocmd("TermClose", {
				pattern = "*lazygit",
				callback = function()
					if package.loaded["neo-tree.sources.git_status"] then
						require("neo-tree.sources.git_status").refresh()
					end
				end,
			})
		end,
	},
}
