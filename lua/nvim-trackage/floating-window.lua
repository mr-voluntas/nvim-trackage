local floating_window = {}

floating_window.table_to_lines = function(data, file_type)
	local lines = {}

	for language, second in pairs(data) do
		local hours = math.floor(second / 3600)
		local minutes = math.floor((second % 3600) / 60)
		local seconds = second % 60

		local time_str = {}

		if hours > 0 then
			table.insert(time_str, hours .. (hours == 1 and " hour" or " hours"))
		end
		if minutes > 0 then
			table.insert(time_str, minutes .. (minutes == 1 and " min" or " mins"))
		end
		if seconds > 0 or (#time_str == 0) then
			table.insert(time_str, seconds .. (seconds == 1 and " second" or " seconds"))
		end

		if file_type == language then
			table.insert(lines, tostring("> " .. language) .. ": " .. tostring(table.concat(time_str, " ")))
		else
			table.insert(lines, tostring(language) .. ": " .. tostring(table.concat(time_str, " ")))
		end
	end

	return lines
end

floating_window.create = function(data, file_type)
	local buf = vim.api.nvim_create_buf(false, true)

	local width = vim.o.columns
	local height = vim.o.lines
	local win_width = math.ceil(width * 0.4)
	local win_height = math.ceil(height * 0.6)
	local row = math.ceil((height - win_height) / 2)
	local col = math.ceil((width - win_width) / 2)

	local opts = {
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		style = "minimal",
		border = "double",
	}

	local win = vim.api.nvim_open_win(buf, true, opts)

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, floating_window.table_to_lines(data, file_type))

	vim.api.nvim_buf_set_keymap(buf, "n", "<esc>", "<Cmd>bd!<CR>", { noremap = true, silent = true })

	return win, buf
end

return floating_window
