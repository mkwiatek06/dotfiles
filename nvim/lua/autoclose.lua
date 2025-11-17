-- Automatic closing of {}, (), [], '', and "" :3

-- Standard closing
vim.keymap.set("i", "{", "{}<Left>")
vim.keymap.set("i", "(", "()<Left>")
vim.keymap.set("i", "[", "[]<Left>")
vim.keymap.set("i", "'", "''<Left>")
vim.keymap.set("i", '"', '""<Left>')

-- Multi-line closing
-- vim.keymap.set("i", "{<cr>", "{<cr>}<C-O><S-O><tab>")
-- vim.keymap.set("i", "(<cr>", "(<cr>)<c-o><s-o><tab>")
-- vim.keymap.set("i", "[<cr>", "[<cr>]<c-o><s-o><tab>")
-- vim.keymap.set("i", "'<cr>", "'<cr>'<c-o><s-o><tab>")
-- vim.keymap.set("i", '"<cr>', '"<cr>"<c-o><s-o><tab>')

-- Multi-line closing
vim.keymap.set("i", "{<cr>", "{<cr>}<C-O><S-O>")
vim.keymap.set("i", "(<cr>", "(<cr>)<c-o><s-o>")
vim.keymap.set("i", "[<cr>", "[<cr>]<c-o><s-o>")
vim.keymap.set("i", "'<cr>", "'<cr>'<c-o><s-o>")
vim.keymap.set("i", '"<cr>', '"<cr>"<c-o><s-o>')


-- Backspace behavior
vim.keymap.set("i", "{<backspace>", "<Nop>")
vim.keymap.set("i", "(<backspace>", "<Nop>")
vim.keymap.set("i", "[<backspace>", "<Nop>")
vim.keymap.set("i", "'<backspace>", "<Nop>")
vim.keymap.set("i", '"<backspace>', "<Nop>")

-- Allow self-closing
vim.keymap.set("i", "{}", "{}")
vim.keymap.set("i", "()", "()")
vim.keymap.set("i", "[]", "[]")
vim.keymap.set("i", "''", "''")
vim.keymap.set("i", '""', '""')

-- Skip closing on Escape
vim.keymap.set("i", "{<Esc>", "{")
vim.keymap.set("i", "(<Esc>", "(")
vim.keymap.set("i", "[<Esc>", "[")
vim.keymap.set("i", "'<Esc>", "'")
vim.keymap.set("i", '"<Esc>', '"')

-- Center space (optional for '  ' and "  ")
vim.keymap.set("i", "{<space>", "{<space><space>}<left><left>")
vim.keymap.set("i", "(<space>", "(<space><space>)<left><left>")
vim.keymap.set("i", "[<space>", "[<space><space>]<left><left>")
-- vim.keymap.set("i", "'<space>", "'<space><space>'<left><left>")
-- vim.keymap.set("i", '"<space>', '"<space><space>"<left><left>')

-- Normal mode closing
vim.keymap.set("n", "(", "mmbi(<esc>ea)<esc>`m<right>")
vim.keymap.set("n", "{", "mmbi{<esc>ea}<esc>`m<right>")
vim.keymap.set("n", "[[", "mmbi[<esc>ea]<esc>`m<right>")
vim.keymap.set("n", "'", "mmbi'<esc>ea'<esc>`m<right>")
vim.keymap.set("n", '"', 'mmbi"<esc>ea"<esc>`m<right>')

-- Visual mode closing
vim.keymap.set("v", "(", "<Esc>`<i(<Esc>`>a<right>)<Esc>")
vim.keymap.set("v", "{", "<Esc>`<i{<Esc>`>a<right>}<Esc>")
vim.keymap.set("v", "[[", "<Esc>`<i[<Esc>`>a<right>]<Esc>")
vim.keymap.set("v", "'", "<Esc>`<i'<Esc>`>a<right>'<Esc>")
vim.keymap.set("v", '"', '<Esc>`<i"<Esc>`>a<right>"<Esc>')
