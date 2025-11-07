-- Kolorki :3

vim.cmd[[highlight Normal ctermbg=0 guibg=0 guifg=0]]
vim.cmd[[highlight NonText ctermbg=0 guibg=0]]
vim.cmd[[highlight DiagnosticError guifg=#ff00ff]]
vim.cmd[[highlight DiagnosticWarn guifg=#5f5f87]]
vim.cmd[[highlight DiagnosticInfo guifg=#5f5f87]]
vim.cmd[[highlight DiagnosticHint guifg=#5f5f87]]
vim.cmd[[highlight DiagnosticUnderlineError guisp=#ff00ff]]
vim.cmd[[highlight DiagnosticUnderlineWarn guisp=#5f5f87]]
vim.cmd[[highlight DiagnosticUnderlineInfo guisp=#5f5f87]]
vim.cmd[[highlight DiagnosticUnderlineHint guisp=#5f5f87]]
vim.cmd[[highlight CurSearch guibg=#5500ff guifg=#000000]]
vim.cmd[[highlight Search guibg=#8144fc guifg=#000000]]

vim.api.nvim_set_hl(0, 'SLIndentLinux', { fg = '#002B6C', bg = '#FFFFFF', bold = true })
vim.api.nvim_set_hl(0, 'Separator', { fg = '#002B6C', bg = '#002B6C' })
