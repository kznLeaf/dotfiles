vim.pack.add({
	"https://github.com/j-hui/fidget.nvim",
})

require("fidget").setup({
	-- options
	notification = {
		window = {
			avoid = {
				"NvimTree",
			},
		},
	},
})
