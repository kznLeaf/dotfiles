vim.pack.add({
	"https://github.com/folke/lazydev.nvim",
})
-- only load on lua files
local lazydev_config = {
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
}

local status, lazydev = pcall(require, "lazydev")
if status then
	lazydev.setup(lazydev_config)
end
