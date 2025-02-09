local file_utils = require("file-utils")
local floating_window = require("floating-window")
local trackage_data = require("trackage-data")

local M = {}

M.opts = {
	time_record_file = "./trackage.json",
}

M.setup = function(opt)
	if opt.time_record_file and type(opt.time_record_file) == "string" then
		M.opts.time_record_file = opt.time_record_file
	end

	local data = trackage_data.get(M.opts.time_record_file)

	vim.api.nvim_create_user_command("OpenTrackage", function()
		floating_window.create(data, file_utils.get_file_type())
	end, { desc = "track language" })

	local timer

	local trackageGroup = vim.api.nvim_create_augroup("trackageGroup", {})
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		group = trackageGroup,
		callback = function()
			if file_utils.get_file_type() ~= "not a file" then
				timer = os.time()
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "BufLeave", "VimLeavePre" }, {
		group = trackageGroup,
		callback = function()
			if file_utils.get_file_type() ~= "not a file" then
				if not data[file_utils.get_file_type()] then
					data[file_utils.get_file_type()] = 0
				end

				local updated_trackage_data = data[file_utils.get_file_type()] + os.difftime(os.time(), timer)

				data[file_utils.get_file_type()] = updated_trackage_data

				trackage_data.update(M.opts.time_record_file, data)
			end
		end,
	})
end

return M
