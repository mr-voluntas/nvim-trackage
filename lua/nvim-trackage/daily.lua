local file_utils = require("nvim-trackage/file-utils")

M = {}

M.update_daily_trackage = function(filename, filetype, time)
	local contents, err = file_utils.get_file_contents(filename)

	if err then
		error(err)
	end

	if contents and type("table") then
		if not contents[os.date("%d-%m-%Y")] then
			contents[os.date("%d-%m-%Y")] = {}
		end
		contents[os.date("%d-%m-%Y")][filetype] = (contents[os.date("%d-%m-%Y")][filetype] or 0) + time
	else
		vim.notify(filename)
		vim.notify(filetype)
		vim.notify(time)
		vim.notify(vim.inspect(contents))
	end

	file_utils.update_file(filename, contents)
end

return M
