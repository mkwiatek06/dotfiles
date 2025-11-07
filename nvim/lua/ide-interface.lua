-- Jump to a window with a given filetype (if it exists)
local function jump_to_window(ft)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local cur_ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
    if cur_ft == ft then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.notify("No window with filetype: " .. ft, vim.log.levels.WARN)
end

-- Keymaps
vim.keymap.set('n', '<leader>se', function() jump_to_window("netrw") end,
  { desc = "Jump to netrw window" })

vim.keymap.set('n', '<leader>sq', function() jump_to_window("qf") end,
  { desc = "Jump to diagnostics (quickfix) window" })
