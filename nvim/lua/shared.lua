OS = vim.loop.os_uname().sysname

function CloseWindow(r_title)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local c_title = vim.api.nvim_buf_get_name(buf)
		if c_title:match(r_title) then
			vim.api.nvim_buf_delete(buf, { force = true })
			return true
		end
	end
	return false
end
