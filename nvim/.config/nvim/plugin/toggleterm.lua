vim.pack.add({
	"https://github.com/akinsho/toggleterm.nvim",
})

require("toggleterm").setup({
	open_mapping = [[<C-t>]],
	direction = "float",
	float_opts = {
		border = "curved",
	},
})
