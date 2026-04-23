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
			Snacks.picker.pick({
				source = "harpoon",
				finder = function()
					local output = {}
					for idx, item in ipairs(require("harpoon"):list().items) do
						if item and item.value:match("%S") then
							table.insert(output, {
								idx = idx,
								text = item.value,
								file = item.value,
								pos = { item.context.row, item.context.col },
							})
						end
					end
					return output
				end,
				filter = {
					transform = function()
						return true
					end,
				},
				format = function(item)
					return {
						{ item.text },
						{ ":", "SnacksPickerDelim" },
						{ tostring(item.pos[1]), "SnacksPickerRow" },
						{ ":", "SnacksPickerDelim" },
						{ tostring(item.pos[2]), "SnacksPickerCol" },
					}
				end,
				preview = function(ctx)
					if Snacks.picker.util.path(ctx.item) then
						return Snacks.picker.preview.file(ctx)
					else
						return Snacks.picker.preview.none(ctx)
					end
				end,
				confirm = "jump",
				actions = {
					harpoon_delete = function(picker, item)
						if not item then
							return
						end
						require("harpoon"):list():remove_at(item.idx)
						picker:find({ refresh = true })
					end,
					harpoon_move_up = function(picker, item)
						if not item or item.idx <= 1 then
							return
						end
						local items = require("harpoon"):list().items
						items[item.idx], items[item.idx - 1] = items[item.idx - 1], items[item.idx]
						local new_idx = item.idx - 1
						picker:find({
							refresh = true,
							on_done = function()
								picker.list:move(new_idx, true, true)
							end,
						})
					end,
					harpoon_move_down = function(picker, item)
						if not item then
							return
						end
						local items = require("harpoon"):list().items
						if item.idx >= #items then
							return
						end
						items[item.idx], items[item.idx + 1] = items[item.idx + 1], items[item.idx]
						local new_idx = item.idx + 1
						picker:find({
							refresh = true,
							on_done = function()
								picker.list:move(new_idx, true, true)
							end,
						})
					end,
				},
				win = {
					input = {
						keys = {
							["<C-x>"] = { "harpoon_delete", mode = { "n", "i" } },
							["<C-k>"] = { "harpoon_move_up", mode = { "n", "i" } },
							["<C-j>"] = { "harpoon_move_down", mode = { "n", "i" } },
						},
					},
					list = {
						keys = {
							["dd"] = "harpoon_delete",
							["K"] = "harpoon_move_up",
							["J"] = "harpoon_move_down",
						},
					},
				},
			})
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
