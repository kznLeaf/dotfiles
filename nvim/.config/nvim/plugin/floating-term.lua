-- vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.ceil(math.min(vim.o.columns, math.max(80, vim.o.columns - 20)))
	local height = opts.height or math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines - 10)))

	-- Calculate the position to center the window
	local col = math.ceil(vim.o.columns - width) * 0.5 - 1
	local row = math.ceil(vim.o.lines - height) * 0.5 - 1

	-- Create a buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	end

	-- Define window configuration
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal", -- No borders or extra UI elements
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	}

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	vim.api.nvim_set_option_value(
		"winhighlight",
		"FloatBorder:Normal,NormalFloat:Normal",
		{ win = win, scope = "local" }
	)

	return { buf = buf, win = win }
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		-- if the term has been open, then close
		vim.api.nvim_win_hide(state.floating.win)
	end
	vim.cmd("normal i")
end

-- vim.api.nvim_create_user_command("Ft", toggle_terminal, {})

vim.keymap.set({ "n", "t" }, "<C-t>", toggle_terminal, { desc = "Toggle terminal" })
