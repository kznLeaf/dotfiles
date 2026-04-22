vim.pack.add({
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/hrsh7th/nvim-cmp",
})

vim.api.nvim_create_autocmd("InsertEnter", {
	-- Just before starting Insert mode.
	once = true,
	callback = function()
		local autopairs = require("nvim-autopairs")

		-- configure autopairs
		autopairs.setup({
			check_ts = true, -- enable treesitter
			ts_config = {
				lua = { "string" }, -- don't add pairs in lua string treesitter nodes
				javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
				java = false, -- don't check treesitter on java
			},
		})

		local cmp_ok, cmp = pcall(require, "cmp")
		if cmp_ok then
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end
	end,
})
