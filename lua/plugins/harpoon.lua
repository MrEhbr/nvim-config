return {
    "ThePrimeagen/harpoon",
    lazy = false,
    config = function()
        require("harpoon").setup({})
        local nmap = function(keys, func, desc)
            vim.keymap.set('n', keys, func, {
                desc = desc
            })
        end

        nmap("<leader>ma", function()
            require("harpoon.mark").add_file()
        end, "[a]dd Harpoon [m]ark")
        nmap("<leader>mc", function()
            require("harpoon.mark").clear_all()
        end, "[c]lear All Harpoon [m]arks")
        nmap("<leader>md", function()
            require("harpoon.mark").rm_file()
        end, "[d]elete Harpoon [m]ark")
        nmap("<leader>ml", function()
            require("harpoon.ui").toggle_quick_menu()
        end, "[l]ist Harpoon [m]arks")
        nmap("<leader>mj", function()
            require("harpoon.ui").nav_next()
        end, "Next Harpoon [m]ark")
        nmap("<leader>mk", function()
            require("harpoon.ui").nav_prev()
        end, "Previous Harpoon [m]ark")
        for i = 1, 5 do
            nmap("<leader>" .. i, function()
                require("harpoon.ui").nav_file(i)
            end, "[" .. i .. "]st Harpoon Mark")
        end
    end,

}
