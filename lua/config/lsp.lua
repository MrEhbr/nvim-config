local M = {}

local blink = require("blink.cmp")

M.capabilities = vim.tbl_deep_extend(
	"force",
	{},
	vim.lsp.protocol.make_client_capabilities(),
	blink.get_lsp_capabilities(),
	{
		fileOperations = {
			didRename = true,
			willRename = true,
		},
	}
)

return M
