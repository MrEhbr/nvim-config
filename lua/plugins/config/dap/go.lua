local dapPresent, dap = pcall(require, "dap")

if not dapPresent then
    return
end

local function get_arguments()
    local co = coroutine.running()
    if co then
        return coroutine.create(function()
            local args = {}
            vim.ui.input({ prompt = "Args: " }, function(input)
                args = vim.split(input or "", " ")
            end)
            coroutine.resume(co, args)
        end)
    else
        local args = {}
        vim.ui.input({ prompt = "Args: " }, function(input)
            args = vim.split(input or "", " ")
        end)
        return args
    end
end

local function get_host()
    local function prompt()
        local host = ""
        vim.ui.input({ prompt = "Host: ", default = vim.env.DLV_REMOTE_HOST or "127.0.0.1" }, function(input)
            host = input
        end)
        return host
    end
    local co = coroutine.running()
    if co then
        return coroutine.create(function()
            local host = prompt()
            coroutine.resume(co, host)
        end)
    else
        return prompt()
    end
end

local function get_root_path()
    local function prompt()
        local path = ""
        vim.ui.input({ prompt = "Path on remote: ", default = "/go/src/app" }, function(input)
            path = input
        end)
        return path
    end
    local co = coroutine.running()
    if co then
        return coroutine.create(function()
            local path = prompt()
            coroutine.resume(co, path)
        end)
    else
        return prompt()
    end
end

dap.adapters.go = {
    type = "server",
    port = "40000",
    executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:40000" },
    },
    options = {
        initialize_timeout_sec = 20,
    },
}

dap.adapters.go_remote = function(callback, config)
    -- Wait for delve to start
    vim.defer_fn(function()
        callback({ type = "server", host = config.host, port = config.port })
    end, 100)
end

dap.configurations.go = {
    {
        type = "go_remote",
        name = "Attach To Port (:40000)",
        mode = "remote",
        request = "attach",
        port = "40000",
        host = get_host,
        substitutePath = {
            {
                from = "${workspaceFolder}",
                to = get_root_path,
            },
        },
    },
    {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
    },
    {
        type = "go",
        name = "Debug (Arguments)",
        request = "launch",
        program = "${file}",
        args = get_arguments,
    },
    {
        type = "go",
        name = "Debug Package",
        request = "launch",
        program = "${fileDirname}",
    },
    {
        type = "go",
        name = "Attach",
        mode = "local",
        request = "attach",
        processId = require("dap.utils").pick_process,
    },
    {
        type = "go",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
    },
}
