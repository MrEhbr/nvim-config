return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>ma", function()
			harpoon:list():add()
		end, { desc = "[a]dd Harpoon [m]ark" })

		vim.keymap.set("n", "<leader>mc", function()
			harpoon:list():clear()
		end, { desc = "[c]lear All Harpoon [m]arks" })

		vim.keymap.set("n", "<leader>md", function()
			harpoon:list():remove()
		end, { desc = "[d]elete Harpoon [m]ark" })

		vim.keymap.set("n", "<leader>ml", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "[l]ist Harpoon [m]arks" })

		vim.keymap.set("n", "<leader>mj", function()
			harpoon:list():next()
		end, { desc = "Next Harpoon [m]ark" })

		vim.keymap.set("n", "<leader>mk", function()
			harpoon:list():prev()
		end, { desc = "Previous Harpoon [m]ark" })

		for i = 1, 5 do
			vim.keymap.set("n", "<leader>" .. i, function()
				harpoon:list():select(i)
			end, { desc = "[" .. i .. "] Harpoon Mark" })
		end
	end,
}
