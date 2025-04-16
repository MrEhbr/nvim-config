local M = {}
M.get_dbee_connection = function()
	local conns = {}

	local raw = os.getenv("DBEE_CONNECTIONS")
	if not raw then
		return {}
	end

	local ok, data = pcall(vim.fn.json_decode, raw)
	if not ok then
		error("Could not parse connections from env: DBEE_CONNECTIONS.")
		-- No need to return here after error, execution halts.
	end

	-- Ensure that the decoded data is a table before proceeding
	if type(data) ~= "table" then
		error("Parsed DBEE_CONNECTIONS is not a table.")
	end

	for i, conn in pairs(data) do
		if type(conn) == "table" and conn.url and conn.type and (not string.find(conn.url, "{{")) then
			conn.id = conn.id or ("environment_source_env_" .. i)
			table.insert(conns, conn)
		end
	end

	return conns
end

M.get_connections = function()
	local raw_conns = M.get_dbee_connection()
	local sqlls_conns = {}
	-- local default_connection = os.getenv("DBEE_DEFAULT_CONNECTION")
	local default_connection = nil
	for _, raw_conn in pairs(raw_conns) do
		if raw_conn.url and raw_conn.type then
			local connection = {
				alias = raw_conn.name or "default",
				driver = raw_conn.type,
				dataSourceName = raw_conn.url,
			}
			if connection.driver == "postgres" then
				connection.dataSourceName = string.gsub(connection.dataSourceName, "postgres://", "postgresql://")
				connection.driver = "postgresql"
			end
			if default_connection then
				if default_connection == raw_conn.id then
					table.insert(sqlls_conns, connection)
				end
			else
				table.insert(sqlls_conns, connection)
			end
		end
	end

	return sqlls_conns
end

local function to_yaml(data)
	local json_str = vim.fn.json_encode(data)

	local cmd = "echo " .. vim.fn.shellescape(json_str) .. " | yq -y"
	local handle = io.popen(cmd, "r")
	local yaml_str = handle:read("*a")
	handle:close()

	return yaml_str
end
M.init_sqls_config = function()
	local connections = M.get_connections()

	if #connections == 0 then
		return
	end

	local config = {
		lowercaseKeywords = false,
		connections = connections,
	}
	local config_dir = vim.fn.expand("~/.config") .. "/sqls"
	if not vim.fn.isdirectory(config_dir) then
		vim.fn.mkdir(config_dir, "p")
	end
	local config_path = vim.fn.expand("~/.config") .. "/sqls/config.yml"

	local file = io.open(config_path, "w+")
	if not file then
		vim.notify("Could not open config file for writing: " .. config_path, vim.log.levels.ERROR)
		return
	end

	file:write(to_yaml(config))
end

return M
