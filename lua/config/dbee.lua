local utils = require("dbee.utils")
local api_ui = require("dbee.api.ui")

---@class TabLayout
local TabLayout = {
	---@type integer
	drawer_width = 40,
	---@type integer
	result_height = 20,
	---@type integer
	call_log_height = 20,
	---@type table<string, integer>
	windows = {},
	---@type "immutable"|"close"
	on_switch = "immutable",
	---@type boolean
	is_opened = false,
	---@type integer?
	tab_nr = nil,
	---@type integer?
	original_tab = nil,
}

---@param opts? { on_switch: "immutable"|"close", drawer_width: integer, result_height: integer, call_log_height: integer }
---@return TabLayout
function TabLayout:new(opts)
	opts = opts or {}

	for _, opt in ipairs({ "drawer_width", "result_height", "call_log_height" }) do
		if opts[opt] and opts[opt] < 0 then
			error(opt .. " must be a positive integer. Got: " .. opts[opt])
		end
	end

	local o = setmetatable({}, { __index = self })
	o.windows = {}
	o.is_opened = false
	o.tab_nr = nil
	o.original_tab = nil
	o.on_switch = opts.on_switch or self.on_switch
	o.drawer_width = opts.drawer_width or self.drawer_width
	o.result_height = opts.result_height or self.result_height
	o.call_log_height = opts.call_log_height or self.call_log_height
	return o
end

---@private
---@param on_switch "immutable"|"close"
---@param winid integer
---@param open_fn fun(winid: integer)
---@param is_editor? boolean
function TabLayout:configure_window_on_switch(on_switch, winid, open_fn, is_editor)
	local action
	if on_switch == "close" then
		action = function(_, buf, file)
			if is_editor then
				local note, _ = api_ui.editor_search_note_with_file(file)
				if note then
					return
				end
				note, _ = api_ui.editor_search_note_with_buf(buf)
				if note then
					return
				end
			end
			self:close()
			vim.api.nvim_win_set_buf(0, buf)
		end
	else
		action = function(win, _, _)
			open_fn(win)
		end
	end

	utils.create_singleton_autocmd({ "BufWinEnter", "BufReadPost", "BufNewFile" }, {
		window = winid,
		callback = function(event)
			action(winid, event.buf, event.file)
		end,
	})
end

---@private
---@param winid integer
function TabLayout:configure_window_on_quit(winid)
	utils.create_singleton_autocmd({ "QuitPre" }, {
		window = winid,
		callback = function()
			self:close()
		end,
	})
end

---@return boolean
function TabLayout:is_open()
	return self.is_opened
end

function TabLayout:open()
	if self.is_opened then
		return
	end

	self.original_tab = vim.api.nvim_get_current_tabpage()
	vim.cmd("tabnew")
	self.tab_nr = vim.api.nvim_get_current_tabpage()

	-- Track empty buffer created by tabnew
	local tmp_buf = vim.api.nvim_get_current_buf()

	self.windows = {}

	-- editor
	local editor_win = vim.api.nvim_get_current_win()
	self.windows["editor"] = editor_win
	api_ui.editor_show(editor_win)
	self:configure_window_on_switch(self.on_switch, editor_win, api_ui.editor_show, true)
	self:configure_window_on_quit(editor_win)

	-- result
	vim.cmd("bo" .. self.result_height .. "split")
	local win = vim.api.nvim_get_current_win()
	self.windows["result"] = win
	api_ui.result_show(win)
	self:configure_window_on_switch(self.on_switch, win, api_ui.result_show)
	self:configure_window_on_quit(win)

	-- drawer
	vim.cmd("to" .. self.drawer_width .. "vsplit")
	win = vim.api.nvim_get_current_win()
	self.windows["drawer"] = win
	api_ui.drawer_show(win)
	self:configure_window_on_switch(self.on_switch, win, api_ui.drawer_show)
	self:configure_window_on_quit(win)

	-- call log
	vim.cmd("belowright " .. self.call_log_height .. "split")
	win = vim.api.nvim_get_current_win()
	self.windows["call_log"] = win
	api_ui.call_log_show(win)
	self:configure_window_on_switch(self.on_switch, win, api_ui.call_log_show)
	self:configure_window_on_quit(win)

	-- set cursor to editor
	vim.api.nvim_set_current_win(editor_win)

	-- Delete the temporary empty buffer
	if vim.api.nvim_buf_is_valid(tmp_buf) and vim.api.nvim_buf_get_name(tmp_buf) == "" then
		vim.api.nvim_buf_delete(tmp_buf, { force = true })
	end

	self.is_opened = true
end

---@return boolean success
function TabLayout:reset()
	if not self.is_opened then
		return false
	end
	for _, win in pairs(self.windows) do
		if not vim.api.nvim_win_is_valid(win) then
			return false
		end
	end
	vim.api.nvim_win_set_height(self.windows["result"], self.result_height)
	vim.api.nvim_win_set_width(self.windows["drawer"], self.drawer_width)
	vim.api.nvim_win_set_height(self.windows["call_log"], self.call_log_height)
	return true
end

function TabLayout:close()
	if not self.is_opened then
		return
	end

	local target_tab = nil
	if self.original_tab and vim.api.nvim_tabpage_is_valid(self.original_tab) then
		target_tab = self.original_tab
	end

	if self.tab_nr and vim.api.nvim_tabpage_is_valid(self.tab_nr) then
		for _, win in pairs(self.windows) do
			pcall(function()
				local buf = vim.api.nvim_win_get_buf(win)
				vim.api.nvim_set_option_value("modified", false, { buf = buf })
			end)
		end

		-- Use pcall for tab operations to handle race conditions
		pcall(function()
			vim.api.nvim_set_current_tabpage(self.tab_nr)
			vim.cmd("tabclose!")
		end)
	end

	-- Always attempt to restore original tab even if close failed
	if target_tab and vim.api.nvim_tabpage_is_valid(target_tab) then
		pcall(vim.api.nvim_set_current_tabpage, target_tab)
	end

	self.windows = {}
	self.tab_nr = nil
	self.original_tab = nil
	self.is_opened = false
end

return TabLayout
