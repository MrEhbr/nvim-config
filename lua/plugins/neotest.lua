return {
	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		dependencies = {
			{
				"nvim-neotest/nvim-nio",
				"nvim-lua/plenary.nvim",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-treesitter/nvim-treesitter",

				"nvim-neotest/neotest-plenary",
				"nvim-neotest/neotest-vim-test",
				{ "fredrikaverpil/neotest-golang", version = "*" },
			},
		},

		opts = function(_, opts)
			opts.adapters = opts.adapters or {}
			opts.adapters["neotest-golang"] = {
				go_test_args = {
					"-v",
					"-count=1",
					"-race",
					"-parallel=1",
					"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
				},
			}
			opts.discovery = {
				enabled = false,
				concurrent = 1,
			}
			opts.running = {
				concurrent = true,
			}
			opts.summary = {
				animated = true,
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

			-- Set up Neotest.
			require("neotest").setup(opts)
		end,
		keys = {
			{
				"<leader>tn",
				"<cmd>lua require('neotest').run.run()<CR>",
				desc = "[t]est [n]earest",
			},
			{
				"<leader>tp",
				"<cmd>lua require('neotest').output_panel.toggle()<CR>",
				desc = "[t]est [p]anel",
			},
			{
				"<leader>tf",
				"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
				desc = "[t]est [f]ile",
			},
			{
				"<leader>td",
				"<cmd>lua require('neotest').run.run({strategy='dap'})<CR>",
				desc = "[t]est [d]ebug",
			},
			{
				"<leader>ts",
				"<cmd>lua require('neotest').run.stop()<CR>",
				desc = "[t]est [s]top",
			},
			{
				"<leader>to",
				"<cmd>lua require('neotest').summary.toggle()<CR>",
				desc = "[t]est [o]utput",
			},
		},
	},

	{
		"andythigpen/nvim-coverage",
		ft = { "go" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- https://github.com/andythigpen/nvim-coverage/blob/main/doc/nvim-coverage.txt
			auto_reload = true,
			lang = {
				go = {
					coverage_file = vim.fn.getcwd() .. "/coverage.out",
				},
			},
		},
	},
}
