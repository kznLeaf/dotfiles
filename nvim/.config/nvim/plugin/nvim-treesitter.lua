vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

require("nvim-treesitter").install({
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
