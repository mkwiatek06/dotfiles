function DiffOrig()
	vim.cmd("diffthis")

	vim.cmd("vnew")
	local alt_file = vim.fn.expand("#")
	vim.cmd("read ++edit " .. alt_file)
	vim.cmd("silent 0d_")
	vim.cmd("diffthis")
	local o_buf = vim.api.nvim_get_current_buf()
	vim.bo[o_buf].buftype = "nofile"
	vim.api.nvim_buf_set_name(o_buf, "Diff")
end

vim.keymap.set('n', "<leader>do", DiffOrig)
