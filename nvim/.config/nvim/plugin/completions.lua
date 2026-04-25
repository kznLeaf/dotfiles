local start = function()
	vim.pack.add({
		{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
		{ src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2.*") },
		"https://github.com/rafamadriz/friendly-snippets", -- Set of preconfigured snippets for different languages.
	})

	require("blink.cmp").setup({
		snippets = { preset = "luasnip" },

		-- All presets have the following mappings:
		-- C-e: Hide completion menu
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-k: Toggle signature help (if signature.enabled = true)
		-- Tab/S-Tab: Jumps to the next/previous snippet placeholder
		keymap = {
			preset = "default",
			-- because C-space will conflict with switching input methods...
			["<C-g>"] = { "show", "show_documentation", "hide_documentation" },
			-- press 'Enter' to select and accept
			["<CR>"] = { "select_and_accept", "fallback" },
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				window = { border = "rounded" },
			},
			menu = {
				-- border = "rounded",
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		signature = { enabled = true },
		fuzzy = { implementation = "prefer_rust_with_warning" },
	})

	require("luasnip").filetype_extend("htmlangular", { "html" })
	require("luasnip.loaders.from_vscode").lazy_load()
end

-- blink needs 30~ms to setup, so just lazy load :)
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = start,
})
