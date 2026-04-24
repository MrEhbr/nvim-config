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
			schemaStore = {
				-- disable built-in schemaStore; SchemaStore.nvim provides schemas
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
		},
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
	},
}
