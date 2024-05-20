return {
    "numToStr/Comment.nvim",
    keys = {
        { "gcc", mode = "n",          desc = "Comment toggle current line" },
        { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
        { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
        { "gbc", mode = "n",          desc = "Comment toggle current block" },
        { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
        { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
    },
    init = function()
        local map = vim.keymap.set
        map({ "n", "v" }, "<leader>/",
            function()
                require("Comment.api").toggle.linewise.current()
            end,
            { desc = "Toggle comment" })
        map({ "v" }, "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            { desc = "Toggle comment" })
    end,
    config = function(_, opts)
        require("Comment").setup(opts)
    end,
}
