local lsp_utils = require("config.lsp")

local function get_cargo_features()
	local client = vim.lsp.get_clients({ name = "rust-analyzer" })[1]
	local cwd = client and client.root_dir or vim.fn.getcwd()

	local output = vim.fn.system({ "cargo", "metadata", "--no-deps", "--format-version", "1", "--manifest-path", cwd .. "/Cargo.toml" })
	if vim.v.shell_error ~= 0 then
		return {}
	end

	local ok, data = pcall(vim.json.decode, output)
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
	return features
end

local function complete_features(arg)
	local features = get_cargo_features()
	return vim.tbl_filter(function(f)
		return f:sub(1, #arg) == arg
	end, features)
end

local function reload_workspace(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "rust-analyzer" })
	for _, client in ipairs(clients) do
		vim.notify("Reloading Cargo Workspace")
		---@diagnostic disable-next-line: param-type-mismatch
		client:request("rust-analyzer/reloadWorkspace", nil, function(err)
			if err then
				error(tostring(err))
			end
			vim.notify("Cargo workspace reloaded")
		end)
	end
end

local function is_library(fname)
	local user_home = vim.fs.normalize(vim.env.HOME)
	local cargo_home = os.getenv("CARGO_HOME") or user_home .. "/.cargo"
	local registry = cargo_home .. "/registry/src"
	local git_registry = cargo_home .. "/git/checkouts"

	local rustup_home = os.getenv("RUSTUP_HOME") or user_home .. "/.rustup"
	local toolchains = rustup_home .. "/toolchains"

	for _, item in ipairs({ toolchains, registry, git_registry }) do
		if vim.fs.relpath(item, fname) then
			local clients = vim.lsp.get_clients({ name = "rust-analyzer" })
			return #clients > 0 and clients[#clients].config.root_dir or nil
		end
	end
end

return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local reused_dir = is_library(fname)
		if reused_dir then
			on_dir(reused_dir)
			return
		end

		local cargo_crate_dir = vim.fs.root(fname, { "Cargo.toml" })
		local cargo_workspace_root

		if cargo_crate_dir == nil then
			on_dir(
				vim.fs.root(fname, { "rust-project.json" })
					or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
			)
			return
		end

		local cmd = {
			"cargo",
			"metadata",
			"--no-deps",
			"--format-version",
			"1",
			"--manifest-path",
			cargo_crate_dir .. "/Cargo.toml",
		}

		vim.system(cmd, { text = true }, function(output)
			if output.code == 0 then
				if output.stdout then
					local result = vim.json.decode(output.stdout)
					if result["workspace_root"] then
						cargo_workspace_root = vim.fs.normalize(result["workspace_root"])
					end
				end

				on_dir(cargo_workspace_root or cargo_crate_dir)
			else
				vim.schedule(function()
					vim.notify(
						("[rust_analyzer] cmd failed with code %d: %s\n%s"):format(output.code, cmd, output.stderr)
					)
				end)
			end
		end)
	end,
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

	capabilities = vim.tbl_deep_extend("force", lsp_utils.capabilities, {
		experimental = {
			serverStatusNotification = true,
		},
	}),

	before_init = function(init_params, config)
		-- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
		if config.settings and config.settings["rust-analyzer"] then
			init_params.initializationOptions = config.settings["rust-analyzer"]
		end
	end,
	on_attach = function()
		vim.api.nvim_buf_create_user_command(0, "LspCargoReload", function()
			reload_workspace(0)
		end, { desc = "Reload current cargo workspace" })

		vim.api.nvim_buf_create_user_command(0, "LspCargoFeatures", function(opts)
			---@type table<string, any>
			local settings = vim.lsp.get_clients({ name = "rust-analyzer" })[1].config.settings
			settings["rust-analyzer"].cargo.features = opts.fargs
			vim.lsp.enable("rust-analyzer", false)
			vim.lsp.config("rust-analyzer", { settings = settings })
			vim.lsp.enable("rust-analyzer")
		end, { desc = "Set rust-analyzer cargo features", nargs = "*", complete = complete_features })

		vim.api.nvim_buf_create_user_command(0, "LspCargoFeaturesAll", function()
			---@type table<string, any>
			local settings = vim.lsp.get_clients({ name = "rust-analyzer" })[1].config.settings
			settings["rust-analyzer"].cargo.features = "all"
			vim.lsp.enable("rust-analyzer", false)
			vim.lsp.config("rust-analyzer", { settings = settings })
			vim.lsp.enable("rust-analyzer")
		end, { desc = "Enable all rust-analyzer cargo features" })

		vim.api.nvim_buf_create_user_command(0, "LspCargoFeaturesList", function()
			---@type table<string, any>
			local settings = vim.lsp.get_clients({ name = "rust-analyzer" })[1].config.settings
			local features = settings["rust-analyzer"].cargo.features
			if features == "all" then
				print("all features enabled")
			elseif type(features) == "table" and #features > 0 then
				print("[" .. table.concat(features, ", ") .. "]")
			else
				print("no features enabled")
			end
		end, { desc = "List rust-analyzer cargo features" })
	end,
}
