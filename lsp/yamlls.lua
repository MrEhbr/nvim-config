return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
	root_markers = { ".git" },
	settings = {
		yaml = {
			format = { enable = true, singleQuote = true, bracketSpacing = true },
			validate = true,
			completion = true,
			editor = { formatOnType = true },
		},
		schemaStore = {
			enable = false,
			url = "",
		},
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
	},
}
