vim.keymap.set('x', '<leader>qc', function()
	vim.cmd('normal! "cy')
	local color = vim.fn.getreg('c')
	if
		color:match("^#?%x%x%x$")
		or color:match("^#?%x%x%x%x%x%x%x?%x?$")
		or color:match("^rgba?%((%d+), (%d+), (%d+),?%s?([%d%.]*)%)$")
		or color:match("^hsla?%((%d+), (%d+%.?%d*)%%, (%d+%.?%d*)%%,?%s?(%d*%.?%d*)%%%)$")
	then
		CloseWindow("ColorInfo")
		vim.cmd("botright 10sp term://zsh -c " ..
		vim.fn.shellescape("pastel color " .. color:gsub("#", "")))
		vim.cmd("file ColorInfo")
	end
	vim.fn.setreg('c', '')
end, { desc = 'Inspect Color' })

vim.keymap.set('n', '<leader>qc', function()
	CloseWindow("ColorInfo")
end, { desc = 'Close Color Info Window' })
