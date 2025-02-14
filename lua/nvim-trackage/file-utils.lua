local M = {}

local function read_file(filename)
	if not filename and type(filename) ~= "string" then
		error("Expected string, got " .. type(filename))
	end

	local file, err = io.open(filename, "r")

	if err then
		return nil, err
	end

	if file then
		local contents = file:read("*a")
		file:close()
		if contents == "" then
			return nil, "empty file"
		else
			return vim.json.decode(contents), nil
		end
	end
end

local function create_file(filename)
	if not filename and type(filename) ~= "string" then
		error("Expected string, got " .. type(filename))
	end

	local file, err = io.open(filename, "w")

	if err then
		return err
	end

	if file then
		file:write(vim.json.encode({}))
		file:close()
	end
end

M.get_file_contents = function(filename)
	local contents, err = read_file(filename)

	if contents then
		if type(contents) ~= "table" then
			error("Not a JSON format")
		end

		return contents
	end

	if err and err:match("No such file or directory") then
		local create_file_err = create_file(filename)

		if create_file_err then
			error(create_file_err)
		end

		local new_file_contents, new_file_err = read_file(filename)

		if new_file_err then
			error(new_file_err)
		end

		if new_file_contents then
			return new_file_contents
		end
	end
end

M.update_file = function(filename, new_contents)
	if not filename and type(filename) ~= "string" then
		error("Expected string, got " .. type(filename))
	end
	if not new_contents and type(new_contents) ~= "table" then
		error("Expected table, got " .. type(new_contents))
	end

	local file, err = io.open(filename, "w")

	if err then
		err("Could not open file in write mode: " .. err)
	end

	if file then
		file:write(vim.json.encode(new_contents))
		file:close()
	end
end

M.get_file_type_in_buffer = function()
	return vim.api.nvim_buf_get_name(0):match(".*%.(.*)") or "not a file"
end

return M
