local function get_input(prompt_text, default_value)
	return function()
		return vim.fn.input(prompt_text, default_value)
	end
end

local get_host = get_input("Host: ", vim.env.DLV_REMOTE_HOST or "127.0.0.1")
local get_port = get_input("Port: ", vim.env.DLV_REMOTE_PORT or "2345")
local get_root_path = get_input("Path on remote: ", "/go/src/app")

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "rcarriga/nvim-dap-ui", dependencies = "nvim-neotest/nvim-nio" },
		"leoluz/nvim-dap-go",
		{
			"theHamsta/nvim-dap-virtual-text",
			dependencies = { "mfussenegger/nvim-dap" },
			config = true,
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		require("dap.ext.vscode").load_launchjs(vim.fn.getcwd() .. "/.run/launch.json", {})

		-- Define signs with consolidated function calls
		local signs = {
			DapBreakpoint = { text = "●", texthl = "DapBreakpoint" },
			DapBreakpointCondition = { text = "●", texthl = "DapBreakpointCondition" },
			DapLogPoint = { text = "◆", texthl = "DapLogPoint" },
			DapStopped = { text = "", texthl = "DapStopped", numhl = "DapStopped" },
			DapBreakpointRejected = { text = "", texthl = "DapBreakpointRejected", numhl = "DapBreakpointRejected" },
		}
		for name, opts in pairs(signs) do
			vim.fn.sign_define(name, opts)
		end

		-- Basic debugging keymaps
		local keymap = vim.keymap.set
		keymap("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		keymap("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		keymap("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		keymap("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		keymap("n", "<F7>", dapui.toggle, { desc = "Debug: Toggle UI" })
		keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		keymap("n", "<leader>dbc", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint Condition" })
		keymap("n", "<Leader>ds", dap.continue, { desc = "Debug: Start/Continue" })

		-- DAP-Go setup with refactored input functions
		require("dap-go").setup({
			dap_configurations = {
				{
					type = "go",
					name = "Attach To Port (:2345)",
					mode = "remote",
					request = "attach",
					port = get_port,
					host = get_host,
					substitutePath = {
						{
							from = "${workspaceFolder}",
							to = get_root_path,
						},
					},
				},
			},
		})

		---@diagnostic disable-next-line: missing-fields
		dapui.setup({
			layouts = {
				{
					position = "left",
					size = 0.30,
					elements = {
						{ id = "scopes", size = 0.38 },
						{ id = "watches", size = 0.16 },
						{ id = "stacks", size = 0.28 },
						{ id = "breakpoints", size = 0.18 },
					},
				},
				{
					position = "bottom",
					size = 0.30,
					elements = {
						{ id = "repl", size = 0.60 },
						{ id = "console", size = 0.40 },
					},
				},
			},
			windows = { indent = 1 },
			render = {
				max_type_length = 0,
				indent = 1,
			},
		})

		-- Event listeners for DAP and DAP-UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			local tree_present, api = pcall(require, "nvim-tree.api")
			if tree_present and api.tree.is_visible() then
				api.tree.close()
			end
			dapui.open()
		end

		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Keymap restoration logic
		local keymap_restore = {}
		dap.listeners.after.event_initialized["me"] = function()
			for _, buf in pairs(vim.api.nvim_list_bufs()) do
				local keymaps = vim.api.nvim_buf_get_keymap(buf, "n")
				for _, keymap in pairs(keymaps) do
					if keymap.lhs == "K" then
						table.insert(keymap_restore, keymap)
						vim.api.nvim_buf_del_keymap(buf, "n", "K")
					end
				end
			end
			vim.api.nvim_set_keymap("n", "K", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
		end

		dap.listeners.after.event_terminated["me"] = function()
			for _, keymap in pairs(keymap_restore) do
				vim.api.nvim_buf_set_keymap(
					keymap.buffer,
					keymap.mode,
					keymap.lhs,
					keymap.rhs,
					{ silent = keymap.silent == 1 }
				)
			end
			keymap_restore = {}
		end

		-- Include your JavaScript DAP configuration
		require("plugins.config.dap.js")
	end,
}
