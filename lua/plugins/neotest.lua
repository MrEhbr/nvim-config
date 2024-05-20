return {
	"nvim-neotest/neotest",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-neotest/nvim-nio" },
		{ "nvim-treesitter/nvim-treesitter" },
		{ "antoinemadec/FixCursorHold.nvim" },
		{
			"MrEhbr/neotest-go",
			ft = "go",
		},
		{
			"rouge8/neotest-rust",
			ft = "rust",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-go"),
				require("neotest-rust")({
					args = { "--no-capture" },
					dap_adapter = "lldb",
				}),
			},
		})
		local nmap = function(keys, func, desc)
			vim.keymap.set("n", keys, func, {
				desc = desc,
			})
		end

		nmap("<leader>tn", function()
			require("neotest").run.run()
		end, "Run [n]earest [t]est")
		nmap("<leader>tp", function()
			require("neotest").output_panel.toggle()
		end, "[t]est [p]anel")
		nmap("<leader>tf", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, "Run [t]ests in current [f]ile")
		nmap("<leader>td", function()
			require("neotest").run.run({
				strategy = "dap",
			})
		end, "[D]ebug nearest [t]est")
		nmap("<leader>ts", function()
			require("neotest").run.stop()
		end, "[S]top [t]est")
		nmap("<leader>to", function()
			require("neotest").summary.toggle()
		end, "Toggle [t]ests [o]utline")
	end,
}
