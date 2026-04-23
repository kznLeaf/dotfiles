vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
})

local keymap = vim.keymap -- for conciseness

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		---------------------------------------------------------------------------------

		local builtin = require("telescope.builtin")

		opts.desc = "LSP all references"
		keymap.set("n", "gA", builtin.lsp_references, opts) -- show definition, references

		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

		opts.desc = "LSP definitions"
		keymap.set("n", "gd", builtin.lsp_definitions, opts) -- show lsp definitions

		opts.desc = "LSP implementations"
		keymap.set("n", "gi", builtin.lsp_implementations, opts) -- show lsp implementations

		-- opts.desc = "LSP type definitions"
		-- keymap.set("n", "gt", builtin.lsp_type_definitions, opts) -- show lsp type definitions

		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

		opts.desc = "Smart rename"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

		opts.desc = "Show all open buffer diagnostics"
		keymap.set("n", "<leader>D", builtin.diagnostics, opts) -- show  diagnostics for file

		opts.desc = "Show line diagnostics"
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

		opts.desc = "LSP incoming calls (Who calls this?)"
		keymap.set("n", "<leader>li", builtin.lsp_incoming_calls, opts)

		opts.desc = "LSP outgoing calls (What does this call?)"
		keymap.set("n", "<leader>lo", builtin.lsp_outgoing_calls, opts)

		----------------------------------------------------------------------------------------

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)

		opts.desc = "Show documentation for what is under cursor"
		keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, opts) -- show documentation for what is under cursor

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
	end,
	once = true,
})
