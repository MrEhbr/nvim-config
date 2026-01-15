return {
	"kevinhwang91/nvim-ufo",
	event = "BufReadPost",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		local handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local totalLines = vim.api.nvim_buf_line_count(0)
			local foldedLines = endLnum - lnum
			local suffix = (" 󰁂 %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			local rAlignAppndx = math.max(math.min(vim.api.nvim_win_get_width(0), width - 1) - curWidth - sufWidth, 0)
			suffix = " ..." .. (" "):rep(rAlignAppndx - 4) .. suffix
			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end

		require("ufo").setup({
			fold_virt_text_handler = handler,
			provider_selector = function(_, _, _)
				return { "lsp", "indent" }
			end,
		})

		local nmap = function(keys, func, desc)
			vim.keymap.set("n", keys, func, {
				desc = desc,
				silent = true,
			})
		end
		nmap("zR", function()
			require("ufo").openAllFolds()
		end, "Open all folds")
		nmap("zr", function()
			require("ufo").openFoldsExceptKinds()
		end, "Open all folds except kinds")
		nmap("zM", function()
			require("ufo").closeAllFolds()
		end, "Close all folds")
		nmap("zm", function()
			require("ufo").closeFoldsWith()
		end, "Close folds by level")
		nmap("zK", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, "Peek fold")
	end,
}
