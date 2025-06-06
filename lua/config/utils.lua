local M = {}

M.toggle_go_test = function()
	local current_file = vim.fn.expand("%:p")
	if string.match(current_file, "_test.go$") then
		local non_test_file = string.gsub(current_file, "_test.go$", ".go")
		if vim.fn.filereadable(non_test_file) == 1 then
			vim.cmd.edit(non_test_file)
		else
			print("No corresponding non-test file found")
		end
	else
		local test_file = string.gsub(current_file, ".go$", "_test.go")
		if vim.fn.filereadable(test_file) == 1 then
			vim.cmd.edit(test_file)
		else
			print("No corresponding test file found")
		end
	end
end

M.git_url = function(file)
	local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree"):match("true")
	if not is_git_repo then
		return ""
	end

	local repo = vim.fn.systemlist("git remote get-url origin")[1]
	local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]

	repo = repo:gsub("git@([^:]+):", "https://%1/")
	repo = repo:gsub("%.git$", "")

	local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if repo_root then
		file = file:sub(#repo_root + 2)
	end

	local url = string.format("%s/blob/%s/%s", repo, branch, file)
	return url
end

function M.copy_file_path(file, line)
	if not file then
		return
	end

	local git_url = M.git_url(file)
	local vals = {
		["FILENAME"] = vim.fn.fnamemodify(file, ":t"),
		["PATH (CWD)"] = vim.fn.fnamemodify(file, ":.") .. (line and ":" .. line or ""),
		["PATH (HOME)"] = vim.fn.fnamemodify(file, ":~") .. (line and ":" .. line or ""),
		["URI (GIT)"] = git_url ~= "" and (git_url .. (line and "#L" .. line or "")) or "",
	}

	local options = vim.tbl_filter(function(val)
		return vals[val] ~= ""
	end, vim.tbl_keys(vals))
	if vim.tbl_isempty(options) then
		vim.notify("No values to copy", vim.log.levels.WARN)
		return
	end
	table.sort(options)
	vim.ui.select(options, {
		prompt = "Choose to copy to clipboard:",
		format_item = function(list_item)
			return ("%s: %s"):format(list_item, vals[list_item])
		end,
	}, function(choice)
		local result = vals[choice]
		if result then
			vim.fn.setreg("+", result)
			Snacks.notify.info("Yanked `" .. result .. "`")
		end
	end)
end

M.copy_file_path_and_line_number = function()
	local current_file = vim.fn.expand("%:p")
	local current_line = vim.fn.line(".")
	M.copy_file_path(current_file, current_line)
end

return M
