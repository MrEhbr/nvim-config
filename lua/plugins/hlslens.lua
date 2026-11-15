local function search_key(lhs, rhs, desc)
	return { lhs, rhs .. [[<Cmd>lua require("hlslens").start()<CR>]], desc = desc }
end

return {
	"kevinhwang91/nvim-hlslens",
	event = "CmdlineEnter",
	opts = {},
	keys = {
		search_key("n", [[<Cmd>execute("normal! " . v:count1 . "nzzzv")<CR>]], "Next search result"),
		search_key("N", [[<Cmd>execute("normal! " . v:count1 . "Nzzzv")<CR>]], "Prev search result"),
		search_key("*", "*", "Search word forward"),
		search_key("#", "#", "Search word backward"),
		search_key("g*", "g*", "Search partial word forward"),
		search_key("g#", "g#", "Search partial word backward"),
	},
}
