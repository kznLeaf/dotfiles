vim.pack.add({
	"https://github.com/rmagatti/auto-session",
})

require("auto-session").setup({
	auto_restore_enabled = false,
	auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/", "~/Pictures/" },
})

vim.keymap.set("n", "<leader>sr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
vim.keymap.set("n", "<leader>ss", "<cmd>AutoSession save<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
vim.keymap.set("n", "<leader>sd", "<cmd>AutoSession delete<CR>", { desc = "Delete current session" }) -- save workspace session for current working directory
