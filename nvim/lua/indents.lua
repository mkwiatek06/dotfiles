-- better tab (expand dong)
vim.o.expandtab = false -- true: use spaces | false: use the <tab> character
vim.o.autoindent = false
vim.o.smartindent = false
vim.o.cindent = false
vim.o.smarttab = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
-- vim.o.shiftwidth = 8 -- undefine to always use 1 tab per indent

vim.keymap.set('n', '<leader>t8', function()
	vim.bo.tabstop = 8
	vim.bo.softtabstop = 8
end, { desc = "Set tab width to 8" })

vim.keymap.set('n', '<leader>t4', function()
	vim.bo.tabstop = 4
	vim.bo.softtabstop = 4
end, { desc = "Set tab width to 4" })

vim.keymap.set('n', '<leader>t2', function()
	vim.bo.tabstop = 2
	vim.bo.softtabstop = 2
end, { desc = "Set tab width to 2" })

vim.keymap.set('n', '<leader>tr', function()
	vim.cmd('normal! gg=G')
	vim.cmd('echo "Indents reformatted."')
end, { desc = "Reformat indents" })
