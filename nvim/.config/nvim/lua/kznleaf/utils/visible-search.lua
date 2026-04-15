local M = {}

local ns_id = vim.api.nvim_create_namespace("visual_scope_highlight")

function M.search()
	local start_line = vim.fn.line("w0")
	local end_line = vim.fn.line("w$")
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

	local fuzzyresult = {}

	local strmap = {}

	for i, line in ipairs(lines) do
		local abs_line = start_line + i - 1
		if not strmap[line] then
			strmap[line] = {}
		end
		table.insert(strmap[line], abs_line)
	end

	local function update_highlights(input)
		vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
		if input == "" then
			return
		end

		fuzzyresult = vim.fn.matchfuzzypos(lines, input)
		local matched_strings = fuzzyresult[1]
		local matched_positions = fuzzyresult[2]

		if #matched_strings == 0 then
			return
		end

		for idx, match_str in ipairs(matched_strings) do
			local rows = strmap[match_str] -- multi rows
			local cols = matched_positions[idx]
			-- 判断是否为评分最高的第一个匹配项
			local hl_group = (idx == 1) and "IncSearch" or "Search"
			local priority = (idx == 1) and 200 or 150

			for _, row_val in ipairs(rows) do
				for _, col in ipairs(cols) do
					vim.api.nvim_buf_set_extmark(0, ns_id, row_val - 1, col, {
						end_col = col + 1,
						hl_group = hl_group,
						priority = priority,
					})
				end
			end
		end
	end

	-- 创建自动命令监听命令行输入变化
	local au_id = vim.api.nvim_create_autocmd("CmdlineChanged", {
		-- 命令行发生任何变化，都会执行callback
		group = vim.api.nvim_create_augroup("FuzzyLiveHL", { clear = true }), -- 清空已经存在的监听器
		callback = function()
			-- callback 只在某事件发生之后，才会被调用，叫做回调。
			local current_input = vim.fn.getcmdline()
			update_highlights(current_input)
			vim.cmd("redraw") -- 强制刷新界面显示高亮
		end,
	})

	-- 获取输入（注意：这里用 input 会阻塞，但自动命令会在后台生效）
	local ok, input = pcall(vim.fn.input, "Fuzzy Search: ")

	-- 结束后清理：移除自动命令
	vim.api.nvim_del_autocmd(au_id)

	-- 处理最终结果
	if not ok or input == "" then
		vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
		return
	end

	if #fuzzyresult[1] > 0 then
		local matched_strings = fuzzyresult[1]
		local matched_positions = fuzzyresult[2]

		local first_match_str = matched_strings[1]
		local rows = strmap[first_match_str]
		if rows and #rows > 0 then
			-- 如果有多个重复行，matchfuzzypos 默认会将第一个匹配到的行排在前面。
			local target_row = rows[1]

			local target_col = matched_positions[1][1]

			vim.api.nvim_win_set_cursor(0, { target_row, target_col })

			-- vim.fn.histadd("search", input)
		end
	end

	vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
end

return M
