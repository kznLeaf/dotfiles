vim.pack.add({'https://github.com/stevearc/conform.nvim'})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt" },
		go = { "goimports", "gofmt", stop_after_first = true },
		json = { "biome", "prettier", stop_after_first = true },
		javascript = { "biome", "prettier", stop_after_first = true },
		css = { "prettier" },
		toml = { "taplo" },
		html = { "prettier" },
	},
	formatters = {
		biome = { require_cwd = true }, -- Only run this formatter if it's configured in the project root.
	},
	default_format_opts = {
		lsp_format = "fallback",
	},

	format_on_save = function(bufnr)
		local ignore_filetypes = { "sql", "yaml", "yml" }
		if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
			return
		end
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		if bufname:match("/node_modules/") then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
})
