return {
	"mrcjkb/rustaceanvim",
	version = "^5", -- Recommended
	ft = { "rust" },
	init = function()
		vim.g.rustaceanvim = function()
			local mason_registry = require("mason-registry")
			local codelldb = mason_registry.get_package("codelldb")

			local extension_path = codelldb:get_install_path() .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

			local on_attach = require("plugins.config.lsp").on_attach
			local capabilities = require("plugins.config.lsp").capabilities

			local cfg = require("rustaceanvim.config")
			return {
				server = {
					on_attach = on_attach,
					capabilities = capabilities,
				},
				dap = {
					adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			}
		end
	end,
}
