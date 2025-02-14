local file_utils = require("nvim-trackage/file-utils")
local floating_window = require("nvim-trackage/floating-window")
local daily = require("nvim-trackage/daily")

local M = {}

M.opts = {
	time_record_file = "./trackage.json",
}

M.setup = function(opt)
	if opt.time_record_file and type(opt.time_record_file) == "string" then
		if not string.find(opt.time_record_file, ".json") then
			error("'opt.time_record_file' must be JSON file type")
		end
		M.opts.time_record_file = opt.time_record_file
	end

	local trackage_data = file_utils.get_file_contents(M.opts.time_record_file)

	vim.api.nvim_create_user_command("OpenTrackage", function()
		floating_window.open(trackage_data)
	end, { desc = "track language" })

	local timer

	local TrackageGroup = vim.api.nvim_create_augroup("TrackageGroup", {})
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		group = TrackageGroup,
		callback = function()
			if file_utils.get_file_type_in_buffer() ~= "not a file" then
				timer = os.time()
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "BufLeave", "VimLeavePre" }, {
		group = TrackageGroup,
		callback = function()
			local file_type = file_utils.get_file_type_in_buffer()

			if file_type ~= "not a file" then
				local time_in_buffer = os.difftime(os.time(), timer)
				-- trackage_data[file_type] = (trackage_data[file_type] or 0) + time_in_buffer

				-- file_utils.update_file(M.opts.time_record_file, trackage_data)
				daily.update_daily_trackage(M.opts.time_record_file, file_type, time_in_buffer)
			end
		end,
	})
end

return M
