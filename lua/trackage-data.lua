local file_utils = require("file-utils")

local trackage_data = {}

trackage_data.get = function(filename)
	local contents, err = file_utils.read_file(filename)

	if contents then
		return contents
	end

	if err and err:match("No such file or directory") then
		file_utils.create_file(filename)
		local newContents, newErr = file_utils.read_file(filename)

		if newErr then
			error(err)
		end

		if newContents then
			return newContents
		end
	end
end

trackage_data.update = function(filename, newContents)
	if type(filename) ~= "string" then
		error("Expected string, got " .. type(filename))
	end
	if type(newContents) ~= "table" then
		error("Expected table, got " .. type(newContents))
	end
	local file = io.open(filename, "w")

	if not file then
		return nil, "Could not open file " .. filename
	end

	file:write(vim.json.encode(newContents))
	file:close()
end

return trackage_data
