vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/folke/todo-comments.nvim",
			"https://github.com/nvim-lua/plenary.nvim",
		})
		local todo_comments = require("todo-comments")
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos in cwd" })
		-- keymap.set("n", "]t", function()
		-- 	todo_comments.jump_next()
		-- end, { desc = "Next todo comment" })
		--
		-- keymap.set("n", "[t", function()
		-- 	todo_comments.jump_prev()
		-- end, { desc = "Previous todo comment" })

		todo_comments.setup()
	end,
})
