return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "󰍵" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "│" },
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			map({ "n", "v" }, "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, {
				expr = true,
				desc = "Jump to next hunk",
			})

			map({ "n", "v" }, "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, {
				expr = true,
				desc = "Jump to previous hunk",
			})

			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, {
				desc = "[s]tage git [h]unk",
			})
			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, {
				desc = "[r]eset git [h]unk",
			})
			map("n", "<leader>hs", gs.stage_hunk, {
				desc = "[s]tage git [h]unk",
			})
			map("n", "<leader>hr", gs.reset_hunk, {
				desc = "[r]eset git [h]unk",
			})
			map("n", "<leader>hS", gs.stage_buffer, {
				desc = "[S]tage All [h]unks in Buffer",
			})
			map("n", "<leader>hu", gs.undo_stage_hunk, {
				desc = "[u]ndo Stage of Git [h]unk",
			})
			map("n", "<leader>hR", gs.reset_buffer, {
				desc = "[R]eset All Git Hunks in Buffer",
			})
			map("n", "<leader>hp", gs.preview_hunk, {
				desc = "[p]review Git [h]unk",
			})
			map("n", "<leader>hb", function()
				gs.blame_line({
					full = true,
				})
			end, {
				desc = "Git [b]lame for Current Line",
			})

			map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>", {
				desc = "[t]oggle Git Line [b]lame",
			})
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {
				desc = "select git hunk",
			})
		end,
	},
}
