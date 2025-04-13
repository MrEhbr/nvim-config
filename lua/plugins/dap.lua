-- Define signs with consolidated function calls
local signs = {
	DapBreakpoint = { text = "●", texthl = "DapBreakpoint" },
	DapBreakpointCondition = { text = "●", texthl = "DapBreakpointCondition" },
	DapLogPoint = { text = "◆", texthl = "DapLogPoint" },
	DapStopped = { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" },
	DapBreakpointRejected = { text = "", linehl = "DapBreakpointRejected", numhl = "DapBreakpointRejected" },
}
for name, opts in pairs(signs) do
	vim.fn.sign_define(name, opts)
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "leoluz/nvim-dap-go", opts = {}, ft = "go" },
			{
				"MrEhbr/dap-rust.nvim",
				ft = "rust",
				config = function()
					local mason_registry = require("mason-registry")
					local codelldb = mason_registry.get_package("codelldb")

					local extension_path = codelldb:get_install_path() .. "/extension/"
					local codelldb_path = extension_path .. "adapter/codelldb"
					local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
					require("dap-rust").setup({
						codelldb = {
							path = codelldb_path,
							lib_path = liblldb_path,
						},
					})
				end,
			},
		},
		event = "VeryLazy",
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
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
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
			local configurations = require("dap.ext.vscode").getconfigs(vim.fn.getcwd() .. "/.run/launch.json")

			for _, config in ipairs(configurations) do
				assert(config.type, "Configuration in launch.json must have a 'type' key")
				assert(config.name, "Configuration in launch.json must have a 'name' key")

				local dap_configurations = dap.configurations[config.type] or {}
				for i, dap_config in pairs(dap_configurations) do
					if dap_config.name == config.name then
						-- remove old value
						table.remove(dap_configurations, i)
					end
				end
				table.insert(dap_configurations, config)
				dap.configurations[config.type] = dap_configurations
			end
		end,
	},
	{
		"igorlfs/nvim-dap-view",
		event = "VeryLazy",
		opts = {
			winbar = {
				sections = { "watches", "scopes", "breakpoints", "repl" },
				default_section = "scopes",
			},
			windows = {
				terminal = {
					hide = { "go" },
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
		opts = {},
	},
}
