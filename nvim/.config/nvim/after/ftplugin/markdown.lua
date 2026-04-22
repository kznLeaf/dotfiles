-- 针对 Markdown 的局部自动换行逻辑 (使用 Autocmd)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		-- 局部生效，不影响 Go 代码
		vim.opt_local.wrap = true -- 开启软换行
		vim.opt_local.linebreak = true -- 单词边界折行
		-- vim.opt_local.breakindent = true -- 折行后保持缩进
		-- vim.opt_local.textwidth = 0 -- 禁用硬换行插入 \n

		-- 视觉行移动映射：让光标在折行后的长句中按“行”移动
		local bopts = { buffer = true, silent = true }
		vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, replace_keycodes = false, unpack(bopts) })
		vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, replace_keycodes = false, unpack(bopts) })
	end,
})
