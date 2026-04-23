vim.pack.add({
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/mason-org/mason.nvim",
})

-- enable mason and configure icons
require("mason").setup({ -- setup is required
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"html",
		"cssls",
		"lua_ls",
		"pyright",
		"gopls",
		"yamlls",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"isort",
		"black",
		"taplo",
		"eslint_d",
	},
})
