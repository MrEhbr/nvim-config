return {
	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",

			"nvim-neotest/neotest-plenary",
			"nvim-neotest/neotest-vim-test",

			{ "fredrikaverpil/neotest-golang", branch = "main" },
			"rouge8/neotest-rust",
		},
		opts = function(_, opts)
			opts.adapters = opts.adapters or {}
			opts.adapters["neotest-golang"] = {
				runner = "gotestsum",
				gotestsum_args = { "--format=testdox" },
				go_test_args = {
					"-v",
					"-race",
					"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
				},
				dap_mode = "manual",
				dap_manual_config = {
					name = "Debug go tests",
					type = "go",
					request = "launch",
					mode = "test",
				},
			}
			opts.adapters["neotest-rust"] = {
				args = { "--no-capture" },
				dap_adapter = "rust",
			}
		end,
		config = function(_, opts)
			if opts.adapters then
				local adapters = {}
				for name, config in pairs(opts.adapters or {}) do
					if type(name) == "number" then
						if type(config) == "string" then
							config = require(config)
						end
						adapters[#adapters + 1] = config
					elseif config ~= false then
						local adapter = require(name)
						if type(config) == "table" and not vim.tbl_isempty(config) then
							local meta = getmetatable(adapter)
							if adapter.setup then
								adapter.setup(config)
							elseif adapter.adapter then
								adapter.adapter(config)
								adapter = adapter.adapter
							elseif meta and meta.__call then
								adapter(config)
							else
								error("Adapter " .. name .. " does not support setup")
							end
						end
						adapters[#adapters + 1] = adapter
					end
				end
				opts.adapters = adapters
			end

			require("neotest").setup(opts)
		end,
		keys = {
			{
				"<leader>ta",
				function()
					require("neotest").run.attach()
				end,
				desc = "[t]est [a]ttach",
			},
			{
				"<leader>tf",
				function()
					require("neotest").output_panel.clear()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "[t]est run [f]ile",
			},
			{
				"<leader>tA",
				function()
					require("neotest").output_panel.clear()
					require("neotest").run.run(vim.uv.cwd())
				end,
				desc = "[t]est [A]ll files",
			},
			{
				"<leader>tS",
				function()
					require("neotest").output_panel.clear()
					require("neotest").run.run({ suite = true })
				end,
				desc = "[t]est [S]uite",
			},
			{
				"<leader>tn",
				function()
					require("neotest").output_panel.clear()
					require("neotest").run.run()
				end,
				desc = "[t]est [n]earest",
			},
			{
				"<leader>tl",
				function()
					require("neotest").output_panel.clear()

					require("neotest").run.run_last()
				end,
				desc = "[t]est [l]ast",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "[t]est [s]ummary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "[t]est [o]utput",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "[t]est [O]utput panel",
			},
			{
				"<leader>tt",
				function()
					require("neotest").run.stop()
				end,
				desc = "[t]est [t]erminate",
			},
			{
				"<leader>td",
				function()
					require("neotest").run.run({ suite = false, strategy = "dap" })
				end,
				desc = "Debug nearest test",
			},
			{
				"<leader>tD",
				function()
					require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
				end,
				desc = "Debug current file",
			},
		},
	},

	{
		"andythigpen/nvim-coverage",
		ft = { "go" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			auto_reload = true,
			lang = {
				go = {
					coverage_file = vim.fn.getcwd() .. "/coverage.out",
				},
			},
		},
	},
}
