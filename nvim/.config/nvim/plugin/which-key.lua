-- lazy loaded
vim.schedule(function()
	vim.pack.add({ "https://github.com/folke/which-key.nvim", "https://github.com/nvim-mini/mini.icons" })
	local status_ok, wk = pcall(require, "which-key")
	if not status_ok then
		return
	end

	wk.setup({
		spec = {
			{ "<Esc><Esc>", hidden = true },
		},
	})
end)
