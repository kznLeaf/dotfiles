return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
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
			-- -- automatic_enable = false,
			-- automatic_setup = false,
			-- automatic_installation = false,
			-- handlers = nil,
			ensure_installed = {
				"html",
				"cssls",
				"lua_ls",
				"pyright",
				"gopls",
				"yamlls",
				"rust_analyzer", -- or use rustaceanvim
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"taplo",
				"biome",
				"eslint_d",
			},
		})
	end,
}
