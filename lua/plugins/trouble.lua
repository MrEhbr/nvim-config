return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "LspAttach",
    cmd = { "Trouble", "TroubleToggle" },
    config = function()
        require("trouble").setup({})

        local nmap = function(keys, func, desc)
            vim.keymap.set('n', keys, func, {
                desc = desc
            })
        end
        nmap("<leader>qq", function()
            require("trouble").toggle()
        end, "Toggle Diagnostics List (via Trouble plugin)")
        nmap("<leader>qw", function()
            require("trouble").toggle("workspace_diagnostics")
        end, "Workspace diagnostics")
        nmap("<leader>qd", function()
            require("trouble").toggle("document_diagnostics")
        end, "Document diagnostics")
        nmap("<leader>qr", function()
            require("trouble").toggle("lsp_references")
        end, "LSP references (via Trouble plugin)")
    end,
}
