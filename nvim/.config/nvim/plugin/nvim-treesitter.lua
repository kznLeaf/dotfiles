vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

local ts = require("nvim-treesitter")

ts.install({
	"go",
	"gomod",
	"gosum",
	"rust",
	"python",
	"proto",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"c",
	"markdown",
	"markdown_inline",
	"json",
	"yaml",
	"bash",
	"dockerfile",
	"gitignore",
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		pcall(vim.treesitter.start, bufnr)
	end,
})
