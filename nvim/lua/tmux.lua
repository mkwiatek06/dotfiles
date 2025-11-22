vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
	callback = function()
		vim.opt.guicursor = ""
		vim.fn.chansend(vim.v.stderr, "\x1b[ q")
	end, desc = "Restore terminal cursor"
})
