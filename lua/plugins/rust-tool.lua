return {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
        local rt = require("rust-tools")
        local mason_registry = require("mason-registry")

        local on_attach = require("plugins.config.lsp").on_attach
        local capabilities = require("plugins.config.lsp").capabilities

        local codelldb = mason_registry.get_package("codelldb")

        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

        rt.setup({
            dap = {
                adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            },
            server = {
                on_attach = on_attach,
                capabilities = capabilities,
            },
            tools = {
                hover_actions = {
                    auto_focus = true,
                },
            },
        })
    end,
}
