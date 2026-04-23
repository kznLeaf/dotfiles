-- See https://neovim.io/doc/user/pack/#vim.pack-events
-- and https://www.reddit.com/r/neovim/comments/1pzwnls/vimpack_with_telescopefzfnative_how/
local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
		vim.print(ev.data.path)
		vim.system({ "make" }, { cwd = ev.data.path }):wait()
	end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })

vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/folke/todo-comments.nvim",
})

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		path_display = { "smart" },
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
	extensions = {
		fzf = {},
	},
})

-- pcall(telescope.load_extension, "fzf")
-- You can excute `make` in ~/.local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim
require("telescope").load_extension("fzf")

-- set keymaps
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in cwd" })
vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Lists items in the quickfix list" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fg", builtin.current_buffer_fuzzy_find, { desc = "Telescope file fuzzy finder" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags)

-- This keymap can be used to navigate
vim.keymap.set("n", "<leader>b", function()
	builtin.buffers({
		sort_mru = true, -- Most Recently Used
		ignore_current_buffer = true,
		show_all_buffers = false, -- Do not show unloaded buffers
	})
end, { desc = "Navigate into loaded buffers" })

vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>en", function()
	builtin.find_files({
		cwd = vim.fn.stdpath("config"),
	})
end)

-- vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find git files" })
-- vim.keymap.set("n", "<leader>sc", builtin.colorscheme, { desc = "Telescope Switch colorscheme" })
-- vim.keymap.set("n", "<leader>fc", ":Telescope neoclip<CR>", { desc = "Telescope clipboard" })
