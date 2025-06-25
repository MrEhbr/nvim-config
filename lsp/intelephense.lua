return {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_markers = { "composer.json", ".git" },
	init_options = {
		licenceKey = os.getenv("INTELEPHENSE_KEY"),
	},
}
