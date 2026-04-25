-- set leader key to space
vim.g.mapleader = " "

-- 按下两次 <Esc> 清除搜索高亮
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

local cl = function()
	local filetype = vim.bo.filetype

	if filetype == "qf" then
		vim.cmd("bd")
	else
		vim.cmd("close")
	end
end

-- window management
-- vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
-- vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
-- vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>w", cl, { desc = "Command 'close'" }) -- only close current split window, Keep the original window

-----------------------------autocmds------------------------------
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.hl.on_yank({ higroup = "DiffText", timeout = 250 })
	end,
})

-- Keymap to copy current diagnostics to the system clipboard
-- vim.keymap.set("n", "<leader>dy", function()
-- 	local current_word = vim.fn.expand("<cword>") -- Get the word under the cursor. E.g. vim
-- 	local diagnostics = vim.diagnostic.get(0) -- Get diagnostics for the current buffer.
-- 	local diagnostic_messages = {}
-- 	for _, diagnostic in ipairs(diagnostics) do
-- 		if string.find(diagnostic.message, current_word) then
-- 			table.insert(diagnostic_messages, diagnostic.message)
-- 		end
-- 	end
-- 	local diagnostic_text = table.concat(diagnostic_messages, "\n")
-- 	vim.fn.setreg("+", diagnostic_text) -- Copy to system clipboard
-- 	print("Diagnostics for '" .. current_word .. "' copied to clipboard")
-- end, { remap = false, desc = "Copy diagnostics to clipboard" })
