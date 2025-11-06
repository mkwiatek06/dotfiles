-- ==> clipboawd <==

-- legacy method
-- vim.api.nvim_create_autocmd('UIEnter', {
--   callback = function()
--     vim.o.clipboard = 'unnamedplus'
--   end
-- })

-- new method
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y', { noremap = true, silent = true,
  desc = "Yank yo clipboawd" }) -- clipboawd
vim.keymap.set('n', '<leader>yy', '"+yy', { noremap = true, silent = true,
  desc = "Yank line to clipboawd" }) -- clipboawd
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p', { noremap = true, silent = true,
  desc = "Paste from clipboawd" }) -- clipboawd
vim.keymap.set('i', '<C-v>', '<C-r><C-p>+', { noremap = true, silent = true,
  desc = "Paste fwom clipboawd in insewt mowd" }) -- clipboawd
