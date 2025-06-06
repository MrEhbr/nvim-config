return {
	"ThePrimeagen/harpoon",
	lazy = false,
	config = function()
		require("harpoon").setup({})
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, {
				desc = desc,
			})
		end

		map("<leader>ma", require("harpoon.mark").add_file, "[a]dd Harpoon [m]ark")
		map("<leader>mc", require("harpoon.mark").clear_all, "[c]lear All Harpoon [m]arks")
		map("<leader>md", require("harpoon.mark").rm_file, "[d]elete Harpoon [m]ark")
		map("<leader>ml", require("harpoon.ui").toggle_quick_menu, "[l]ist Harpoon [m]arks")
		map("<leader>mj", require("harpoon.ui").nav_next, "Next Harpoon [m]ark")
		map("<leader>mk", require("harpoon.ui").nav_prev, "Previous Harpoon [m]ark")
		for i = 1, 5 do
			map("<leader>" .. i, function()
				require("harpoon.ui").nav_file(i)
			end, "[" .. i .. "]st Harpoon Mark")
		end
	end,
}
