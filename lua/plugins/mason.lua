return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
	opts = function()
		return {
			ensure_installed = {
				-- LSP
				"marksman",
				"intelephense",
				"biome",
				"pyright",
				"nil", -- nix
				"templ",
				"gopls",
				"htmx-lsp",
				"tailwindcss-language-server",
				"json-lsp",
				"yaml-language-server",
				"lua-language-server",
				"rust-analyzer",
				"jdtls",
				-- Diagnostic
				"harper-ls",
				-- "golangci-lint",
				"copilot-language-server",

				-- Formatters
				"biome",
				"prettierd",
				"rustywind",
				"shfmt",
				"gofumpt",
				"goimports",
				"goimports-reviser",
				"golines",
				"gomodifytags",
				-- "pint",
				"buf",
				"nixpkgs-fmt",
				"black",
				"stylua",
				"cbfmt",
				"markdownlint",

				-- Debuggers
				"js-debug-adapter",
				"codelldb",
				"delve",
				"php-debug-adapter",
			},
		}
	end,
	config = function(_, opts)
		require("mason").setup(opts)

		vim.api.nvim_create_user_command("MasonInstallAll", function()
			if opts.ensure_installed and #opts.ensure_installed > 0 then
				vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
			end
		end, {})

		vim.g.mason_binaries_list = opts.ensure_installed
	end,
}
