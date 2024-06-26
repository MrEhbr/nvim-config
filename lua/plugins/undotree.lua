return {
    "mbbill/undotree",
    lazy = false,
    config = function()
        vim.g.undotree_WindowLayout = 2
        vim.g.undotree_SplitWidth = 50
        vim.g.undotree_HighlightChangedWithSign = 1
        vim.g.undotree_HighlightSyntaxChange = 'DiffChange'
        vim.g.undotree_HighlightSyntaxAdd = 'DiffAdd'
        vim.g.undotree_HighlightSyntaxDel = 'DiffDelete'

        vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { noremap = true, silent = true },
            { desc = "Toggle undotree" })
    end,
}
