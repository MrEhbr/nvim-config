local M = {}

M.actions = {
	qflist = function(picker)
		picker:close()
		local sel = picker:selected()
		local items = #sel > 0 and sel or picker:items()
		local qf = {}
		for _, item in ipairs(items) do
			qf[#qf + 1] = {
				filename = Snacks.picker.util.path(item),
				bufnr = item.buf,
				lnum = item.pos and item.pos[1] or 1,
				col = item.pos and item.pos[2] + 1 or 1,
				end_lnum = item.end_pos and item.end_pos[1] or nil,
				end_col = item.end_pos and item.end_pos[2] + 1 or nil,
				text = item.line or item.comment or item.label or item.name or item.detail or item.text,
				pattern = item.search,
				valid = true,
			}
		end
		vim.fn.setqflist(qf)
		vim.cmd("copen")
	end,
}

function M.actions.copy_file_path(picker, item, action)
	if not item then
		return
	end

	require("config.utils").copy_file_path(item.file)
end

function M.actions.search_in_directory(picker, item, action)
	if not item then
		return
	end
	local dir = vim.fn.fnamemodify(item.file, ":p:h")
	Snacks.picker.grep({
		cwd = dir,
		cmd = "rg",
		args = {
			"-g",
			"!.git",
			"-g",
			"!node_modules",
			"-g",
			"!dist",
			"-g",
			"!build",
			"-g",
			"!coverage",
			"-g",
			"!.DS_Store",
			"-g",
			"!.dart_tool",
		},
		show_empty = true,
		hidden = true,
		ignored = true,
		follow = false,
		supports_live = true,
	})
end

function M.actions.diff(picker, item, action)
	picker:close()
	local sel = picker:selected()
	if #sel > 0 and sel then
		Snacks.notify.info(sel[1].file)
		-- vim.cmd("tabnew " .. sel[1].file .. " vert diffs " .. sel[2].file)
		vim.cmd("tabnew " .. sel[1].file)
		vim.cmd("vert diffs " .. sel[2].file)
		Snacks.notify.info("Diffing " .. sel[1].file .. " against " .. sel[2].file)
		return
	end

	Snacks.notify.info("Select two entries for the diff")
end

M.next_dir = function(cwd, filter, opts)
	local Tree = require("snacks.explorer.tree")

	opts = opts or {}
	local path = opts.path or cwd
	local root = Tree:node(cwd) or nil
	if not root then
		return
	end

	local first ---@type snacks.picker.explorer.Node?
	local last ---@type snacks.picker.explorer.Node?
	local prev ---@type snacks.picker.explorer.Node?
	local next ---@type snacks.picker.explorer.Node?
	local found = false

	-- Walk through all open/visible directories
	Tree:walk(root, function(node)
		local want = node.dir and filter(node) and not node.ignored
		if node.path == path then
			found = true
		end
		if want then
			first, last = first or node, node
			next = next or (found and node.path ~= path and node) or nil
			prev = not found and node or prev
		end
	end, { all = false }) -- Only walk visible/open nodes

	if opts.up then
		return prev or last
	end
	return next or first
end

function M.actions.focus_folder(picker, item, action)
	local actions = require("snacks.explorer.actions")
	---@cast action snacks.explorer.diagnostic.Action
	local node = M.next_dir(picker:cwd(), function(node)
		return true
	end, { up = action.up, path = item and item.file })
	if node then
		actions.update(picker, { target = node.path })
	end
end

M.actions.focus_next_folder = { action = M.actions.focus_folder, up = true }
M.actions.focus_prev_folder = { action = M.actions.focus_folder, up = false }

return M
