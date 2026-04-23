vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
})
-- Function to get the current mode indicator as a single character
local function mode()
	-- Map of modes to their respective shorthand indicators
	local mode_map = {
		n = "(^◡^)", -- Normal mode
		i = "(ﾉ>ω<)ﾉ", -- Insert mode
		v = "(✪ω✪)", -- Visual mode
		[""] = "(✪ω✪)", -- Visual block mode
		V = "(✪ω✪)", -- Visual line mode
		c = "COMMAND", -- Command-line mode
		no = "(¬_¬)", -- NInsert mode
		t = "d(=_=)b", -- Terminal mode

		s = "SELECT", -- Select mode
		S = "S-LINE", -- Select line mode
		ic = "INSERT", -- Insert mode (completion)
		R = "REPLACE", -- Replace mode
		Rv = "V-REPLACE", -- Virtual Replace mode
		cv = "VIM EX", -- Command-line mode
		ce = "NORMAL", -- Ex mode
		r = "ENTER", -- Prompt mode
		rm = "MORE", -- More mode
		["r?"] = "CONFIRM", -- Confirm mode
		["!"] = "SHELL", -- Shell mode
	}
	-- Return the mode shorthand or [UNKNOWN] if no match
	return mode_map[vim.fn.mode()] or "[UNKNOWN]"
end

require("lualine").setup({
	options = {
		theme = "auto",
		-- disabled_filetypes = { "nvim-tree", "Avante", "AvanteInput", "AvanteTodos", "AvanteSelectedFiles" },
		component_separators = { left = "╲", right = "" },
		section_separators = { left = "", right = "" },
		ignore_focus = { "NvimTree" },
	},
	sections = {
		lualine_a = { mode },
		lualine_b = {
			{ "branch", icon = "" },
			-- {
			-- 	"diff",
			-- },
			{
				"diagnostics",
				source = { "nvim" },
				sections = { "error" },
				-- diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
			},
			{
				"diagnostics",
				source = { "nvim" },
				sections = { "warn" },
				-- diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
			},
			{
				"diagnostics",
				source = { "nvim" },
				sections = { "info" },
				-- diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
			},
		},
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "lsp_status" },
		lualine_y = { "%l/%L:%c" },
		lualine_z = { "%p%%" },
	},
	inactive_sections = {
		lualine_c = {
			{
				"filename",
				path = 1,
			},
		},
		lualine_z = {},
	},
	tabline = {
		lualine_a = {
			{
				"buffers",
				hide_filename_extension = false, -- Hide filename extension when set to true.
				max_length = vim.o.columns * 0.75,
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
			},
		},
		-- lualine_b = { "branch" },
		lualine_z = {
			{
				"tabs",
				section_separators = { left = "", right = "" },
			},
		},
	},
	extensions = {},
})
