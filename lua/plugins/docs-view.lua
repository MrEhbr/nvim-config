return {
    {
        "amrbashir/nvim-docs-view",
        cmd = { "DocsViewToggle" },
        config = function()
            require("docs-view").setup({
                position = 'bottom',
                height = 20,
                width = 60,
                update_mode = 'auto',
            })
        end,
    },
}
