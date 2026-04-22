return {
	-- filetypes: go, gomod, gowork, gotmpl
	settings = {
		gopls = {
			completeUnimported = true,
			-- usePlaceholders = true,
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				unusedvariable = true,
				useany = true,
			},
			staticcheck = true,
			-- semanticTokens = true,
		},
	},
}
