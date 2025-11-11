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

function CloseWindows(r_titles)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local c_title = vim.api.nvim_buf_get_name(buf)
		for _, r_title in ipairs(r_titles) do
			if c_title:match(r_title) then
				vim.api.nvim_buf_delete(buf, { force = true })
				return true
			end
		end
	end
	return false
end


-- Auto close auxiliary windows when quitting the last main buffer
vim.api.nvim_create_autocmd("QuitPre", { callback = function()
	local aux_titles = { "Netrw", "DiagnosticsList", "ColorInfo" }
	CloseWindows(aux_titles)
end,
})

