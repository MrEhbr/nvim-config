return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		local harpoon_ext = require("harpoon.extensions")
		local function redraw_tabline()
			vim.schedule(function()
				vim.cmd("redrawtabline")
			end)
		end
		harpoon_ext.extensions:add_listener({
			ADD = redraw_tabline,
			REMOVE = redraw_tabline,
			REORDER = redraw_tabline,
			LIST_CHANGE = redraw_tabline,
		})

		vim.keymap.set("n", "<leader>ma", function()
			local list = harpoon:list()
			local current = list.config.create_list_item(list.config)
			if list:get_by_value(current.value) then
				vim.notify("Harpoon: already marked: " .. current.value, vim.log.levels.WARN)
				return
			end
			list:add()
			vim.notify("Harpoon: added " .. current.value, vim.log.levels.INFO)
		end, { desc = "[a]dd Harpoon [m]ark" })

		vim.keymap.set("n", "<leader>mc", function()
			local count = harpoon:list():length()
			if count == 0 then
				vim.notify("Harpoon: no marks to clear", vim.log.levels.WARN)
				return
			end
			harpoon:list():clear()
			vim.notify("Harpoon: cleared " .. count .. " mark(s)", vim.log.levels.WARN)
		end, { desc = "[c]lear All Harpoon [m]arks" })

		vim.keymap.set("n", "<leader>md", function()
			local list = harpoon:list()
			local current = list.config.create_list_item(list.config)
			if not list:get_by_value(current.value) then
				return
			end
			list:remove()
			vim.notify("Harpoon: removed " .. current.value, vim.log.levels.INFO)
		end, { desc = "[d]elete Harpoon [m]ark" })

		vim.keymap.set("n", "<leader>ml", function()
			Snacks.picker.pick({
				source = "harpoon",
				finder = function()
					local output = {}
					local list = require("harpoon"):list()
					local row = 0
					for i = 1, list:length() do
						local it = list.items[i]
						if it and it.value:match("%S") then
							row = row + 1
							table.insert(output, {
								harpoon_idx = i,
								picker_row = row,
								text = it.value,
								file = it.value,
								pos = { it.context.row, it.context.col },
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
						require("harpoon"):list():remove_at(item.harpoon_idx)
						picker:find({ refresh = true })
					end,
					harpoon_move_up = function(picker, item)
						if not item or item.picker_row <= 1 then
							return
						end
						local list = require("harpoon"):list()
						local prev_idx
						for i = item.harpoon_idx - 1, 1, -1 do
							if list.items[i] then
								prev_idx = i
								break
							end
						end
						if not prev_idx then
							return
						end
						list.items[item.harpoon_idx], list.items[prev_idx] =
							list.items[prev_idx], list.items[item.harpoon_idx]
						harpoon_ext.extensions:emit(harpoon_ext.event_names.REORDER, { list = list })
						local new_row = item.picker_row - 1
						picker:find({
							refresh = true,
							on_done = function()
								picker.list:move(new_row, true, true)
							end,
						})
					end,
					harpoon_move_down = function(picker, item)
						if not item then
							return
						end
						local list = require("harpoon"):list()
						local next_idx
						for i = item.harpoon_idx + 1, list:length() do
							if list.items[i] then
								next_idx = i
								break
							end
						end
						if not next_idx then
							return
						end
						list.items[item.harpoon_idx], list.items[next_idx] =
							list.items[next_idx], list.items[item.harpoon_idx]
						harpoon_ext.extensions:emit(harpoon_ext.event_names.REORDER, { list = list })
						local new_row = item.picker_row + 1
						picker:find({
							refresh = true,
							on_done = function()
								picker.list:move(new_row, true, true)
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
