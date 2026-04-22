vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
})

require("kanagawa").setup({
	-- Remove the background of LineNr, {Sign,Fold}Column and friends
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},
	transparent = false,
})

vim.cmd("colorscheme kanagawa")
