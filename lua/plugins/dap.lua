---@diagnostic disable: missing-fields
local signs = {
	DapBreakpoint = { text = "●", texthl = "DapBreakpoint" },
	DapBreakpointCondition = { text = "●", texthl = "DapBreakpointCondition" },
	DapLogPoint = { text = "◆", texthl = "DapLogPoint" },
	DapStopped = { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" },
	DapBreakpointRejected = { text = "", linehl = "DapBreakpointRejected", numhl = "DapBreakpointRejected" },
}
-- Define custom signs for DAP breakpoints and states
for name, opts in pairs(signs) do
	vim.fn.sign_define(name, opts)
end

local function get_arguments()
	return coroutine.create(function(dap_run_co)
		local args = {}
		vim.ui.input({ prompt = "Args: " }, function(input)
			args = vim.split(input or "", " ")
			coroutine.resume(dap_run_co, args)
		end)
	end)
end

local function go_configurations(dap)
	dap.configurations.go = {
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
			name = "Debug test",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}",
		},
	}
end

local function php_configurations(dap)
	dap.adapters.php = {
		type = "executable",
		command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
	}

	dap.configurations.php = {
		{
			name = "PHP: Listen for Xdebug",
			port = 9003,
			request = "launch",
			type = "php",
			pathMappings = {},
		},
	}
end

return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			{ "leoluz/nvim-dap-go", opts = {}, ft = "go" },
			{
				"MrEhbr/dap-rust.nvim",
				ft = "rust",
				config = function()
					require("dap-rust").setup({
						codelldb = {
							path = vim.fn.expand("$MASON/bin/codelldb"),
							lib_path = vim.fn.expand("$MASON/share/codelldb/lldb/lib/liblldb.dylib"),
						},
					})
				end,
			},
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "toggle [d]ebug [b]reakpoint",
			},
			{
				"<leader>dB",
				function()
					Snacks.input.input({
						prompt = "Breakpoint condition: ",
					}, function(input)
						require("dap").set_breakpoint(input)
					end)
				end,
				desc = "[d]ebug [B]reakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "[d]ebug [c]ontinue (start here)",
			},
			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "[d]ebug [C]ursor",
			},
			{
				"<leader>dg",
				function()
					require("dap").goto_()
				end,
				desc = "[d]ebug [g]o to line",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "[d]ebug step [o]ver",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "[d]ebug step [O]ut",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "[d]ebug [i]nto",
			},
			{
				"<leader>dj",
				function()
					require("dap").down()
				end,
				desc = "[d]ebug [j]ump down",
			},
			{
				"<leader>dk",
				function()
					require("dap").up()
				end,
				desc = "[d]ebug [k]ump up",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "[d]ebug [l]ast",
			},
			{
				"<leader>dp",
				function()
					require("dap").pause()
				end,
				desc = "[d]ebug [p]ause",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "[d]ebug [r]epl",
			},
			{
				"<leader>dR",
				function()
					require("dap").clear_breakpoints()
				end,
				desc = "[d]ebug [R]emove breakpoints",
			},
			{
				"<leader>ds",
				function()
					require("dap").session()
				end,
				desc = "[d]ebug [s]ession",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "[d]ebug [t]erminate",
			},
			{
				"<leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "[d]ebug [h]over",
			},
		},
		config = function(_, _)
			local dap = require("dap")
			go_configurations(dap)
			php_configurations(dap)
			local configurations = require("dap.ext.vscode").getconfigs(vim.fn.getcwd() .. "/.run/launch.json")

			for _, config in ipairs(configurations) do
				assert(config.type, "Configuration in launch.json must have a 'type' key")
				assert(config.name, "Configuration in launch.json must have a 'name' key")

				local dap_configurations = dap.configurations[config.type] or {}
				for i, dap_config in pairs(dap_configurations) do
					if dap_config.name == config.name then
						table.remove(dap_configurations, i)
					end
				end
				table.insert(dap_configurations, config)
				dap.configurations[config.type] = dap_configurations
			end
		end,
	},
	{
		"Jorenar/nvim-dap-disasm",
		dependencies = { "igorlfs/nvim-dap-view" },
		opts = {
			dapview_register = true,
		},
	},
	{
		"igorlfs/nvim-dap-view",
		event = "VeryLazy",
		opts = {
			winbar = {
				controls = {
					position = "left",
					enabled = true,
				},
				sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
				default_section = "scopes",
			},
			windows = {
				terminal = {
					hide = { "go", "php" },
				},
			},
		},
		config = function(_, opts)
			local dap = require("dap")
			local dv = require("dap-view")
			dv.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dv.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dv.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dv.close()
			end
		end,
		keys = {
			{
				"<leader>du",
				function()
					require("dap-view").toggle()
				end,
				desc = "[d]ap [u]i",
			},
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {
			enabled = true,
			enabled_commands = true,
			highlight_changed_variables = true,
			highlight_new_as_changed = true,
			show_stop_reason = true,
			commented = false,
			only_first_definition = true,
			all_references = false,
			clear_on_continue = true,
			virt_text_pos = "eol",
			all_frames = false,
			virt_lines = false,
		},
	},
}
