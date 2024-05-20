local dapPresent, dap = pcall(require, "dap")

if not dapPresent then
    return
end

dap.adapters.chrome = {
    type = "executable",
    command = "chrome-debug-adapter",
}

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
    },
    options = {
        initialize_timeout_sec = 20,
    },
}

for _, language in ipairs({ "typescript", "javascript", "svelte" }) do
    if not dap.configurations[language] then
        dap.configurations[language] = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                runtimeExecutable = "bun",
                runtimeArgs = {
                    "run",
                    "--inspect-wait",
                },
                program = "${file}",
                cwd = "${workspaceFolder}",
                attachSimplePort = 9229,
            },
            {
                type = "pwa-node",
                request = "attach",
                name = "Attach",
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
            },
            {
                type = "chrome",
                request = "attach",
                name = "Attach to Chrome",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                port = 9222,
                webRoot = "${workspaceFolder}",
            },
        }
    end
end
