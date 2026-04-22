vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		-- vim.opt_local.breakindent = true
		-- vim.opt_local.textwidth = 0

		local bopts = { buffer = true, silent = true }
		vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, replace_keycodes = false, unpack(bopts) })
		vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, replace_keycodes = false, unpack(bopts) })
	end,
})
