---@type NvPluginSpec[]
local plugins = {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                },
            })
        end,
    },
    -- {
    --     "sourcegraph/sg.nvim",
    --     enabled = false,
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     cmd = { "CodyAsk", "CodyChat", "CodyToggle", "CodyTask", "CodyTaskView" },
    --     event = "VeryLazy",
    --     config = function()
    --         require("sg").setup({
    --             enable_cody = true,
    --         })
    --     end,
    -- },
    {
        "jackMort/ChatGPT.nvim",
        cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions" },
        config = function()
            require("chatgpt").setup({
                api_key_cmd = "op read op://Personal/OpenAI/credential --no-newline",
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
}

return plugins
