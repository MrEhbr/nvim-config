return {
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				RRGGBBAA = true,
				AARRGGBB = true,
				names = false,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
				tailwind = true,
				mode = "background",
			},
		},
	},
}
