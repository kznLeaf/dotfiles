function EditLineFromLazygit(file_path, line)
	local path = vim.fn.expand("%:p")
	if path == file_path then
		vim.cmd(tostring(line))
	else
		vim.cmd("e " .. file_path)
		vim.cmd(tostring(line))
	end
end

function EditFromLazygit(file_path)
	local path = vim.fn.expand("%:p")
	if path == file_path then
		return
	else
		vim.cmd("e " .. file_path)
	end
end

-- lazy loading
vim.schedule(function()
	vim.pack.add({
		"https://github.com/kdheepak/lazygit.nvim",
		"https://github.com/nvim-lua/plenary.nvim", -- dependency
	})
	vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open lazy git" })
end)
