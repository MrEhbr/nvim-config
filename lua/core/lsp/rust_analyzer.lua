local feature_cache = {}

local function cargo_features(root)
	if feature_cache[root] then
		return feature_cache[root]
	end

	local out = vim.system({
		"cargo",
		"metadata",
		"--no-deps",
		"--format-version",
		"1",
		"--manifest-path",
		root .. "/Cargo.toml",
	}, { text = true }):wait(5000)

	if out.code ~= 0 or not out.stdout then
		return {}
	end

	local ok, data = pcall(vim.json.decode, out.stdout)
	if not ok then
		return {}
	end

	local features = {}
	local seen = {}
	for _, pkg in ipairs(data.packages or {}) do
		for feat, _ in pairs(pkg.features or {}) do
			if not seen[feat] then
				seen[feat] = true
				table.insert(features, feat)
			end
		end
	end

	table.sort(features)
	feature_cache[root] = features
	return features
end

local function clients(bufnr)
	return vim.lsp.get_clients({ bufnr = bufnr, name = "rust_analyzer" })
end

local function complete_features(arg, _, _)
	local client = clients(vim.api.nvim_get_current_buf())[1]
	local root = client and client.root_dir or vim.fn.getcwd()
	return vim.tbl_filter(function(f)
		return f:sub(1, #arg) == arg
	end, cargo_features(root))
end

local function apply(bufnr, mutate)
	for _, client in ipairs(clients(bufnr)) do
		mutate(client.settings["rust-analyzer"])
		client:notify(vim.lsp.protocol.Methods.workspace_didChangeConfiguration, { settings = client.settings })
		vim.lsp.config("rust_analyzer", { settings = client.settings })
	end
end

local function reload_workspace(bufnr)
	for _, client in ipairs(clients(bufnr)) do
		vim.notify("Reloading Cargo Workspace")
		---@diagnostic disable-next-line: param-type-mismatch
		client:request("rust-analyzer/reloadWorkspace", nil, function(err)
			if err then
				vim.notify(tostring(err), vim.log.levels.ERROR)
				return
			end
			vim.notify("Cargo workspace reloaded")
		end)
	end
end

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			cargo = {
				features = {},
			},
			check = {
				command = "clippy",
			},
			diagnostics = {
				enable = true,
			},
		},
	},

	on_attach = function(_, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspCargoReload", function()
			reload_workspace(bufnr)
		end, { desc = "Reload current cargo workspace" })

		vim.api.nvim_buf_create_user_command(bufnr, "LspCargoFeatures", function(opts)
			apply(bufnr, function(ra)
				ra.cargo.features = opts.fargs
				ra.cargo.noDefaultFeatures = opts.bang or nil
			end)
		end, {
			desc = "Set rust-analyzer cargo features (! to also disable default features)",
			nargs = "*",
			bang = true,
			complete = complete_features,
		})

		vim.api.nvim_buf_create_user_command(bufnr, "LspCargoFeaturesAll", function()
			apply(bufnr, function(ra)
				ra.cargo.features = "all"
			end)
		end, { desc = "Enable all rust-analyzer cargo features" })

		vim.api.nvim_buf_create_user_command(bufnr, "LspCargoTarget", function(opts)
			apply(bufnr, function(ra)
				ra.cargo.target = opts.args ~= "" and opts.args or nil
			end)
		end, { desc = "Set rust-analyzer cargo target (empty to reset to host)", nargs = "?" })

		vim.api.nvim_buf_create_user_command(bufnr, "LspCargoFeaturesList", function()
			local client = clients(bufnr)[1]
			if not client then
				return
			end
			local cargo = client.settings["rust-analyzer"].cargo
			local suffix = cargo.noDefaultFeatures and "  (default features disabled)" or ""
			if cargo.features == "all" then
				print("all features enabled")
			elseif type(cargo.features) == "table" and #cargo.features > 0 then
				print("[" .. table.concat(cargo.features, ", ") .. "]" .. suffix)
			else
				print("no features enabled" .. suffix)
			end
		end, { desc = "List rust-analyzer cargo features" })
	end,
})
