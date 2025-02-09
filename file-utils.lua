local file_utils = {}

file_utils.read_file = function(filename)
	if not filename then
		error("Filename required")
	end

	if type(filename) ~= "string" then
		error("Expected String, got .." .. type(filename))
	end

	local file, err = io.open(filename, "r")

	if err then
		return nil, err
	end

	if file then
		local fileContents = file:read("*a")
		file:close()
		if fileContents == "" then
			return nil, "file was empty"
		else
			return vim.json.decode(fileContents), nil
		end
	end
end

file_utils.create_file = function(name)
	local file, err = io.open(name, "w")

	if not file then
		error(err)
	end

	local written, writtenErr = file:write(vim.json.encode({}))

	if not written then
		error(writtenErr)
	end

	file:close()

	return file
end

file_utils.get_file_type = function()
	return vim.api.nvim_buf_get_name(0):match(".*%.(.*)") or "not a file"
end

return file_utils
