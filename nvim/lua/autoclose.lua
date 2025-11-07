-- Automatic closing of {}, (), [], '', and "" :3

-- Standard closing
vim.cmd[[inoremap { {}<Left>]]
vim.cmd[[inoremap ( ()<Left>]]
vim.cmd[[inoremap [ []<Left>]]
vim.cmd[[inoremap ' ''<Left>]]
vim.cmd[[inoremap " ""<Left>]]

-- Multi-line closing
vim.cmd[[inoremap {<cr> {<cr>}<C-O><S-O>]]
vim.cmd[[inoremap (<cr> (<cr>)<c-o><s-o>]]
vim.cmd[[inoremap [<cr> [<cr>]<c-o><s-o><tab>]]
vim.cmd[[inoremap '<cr> '<cr>'<c-o><s-o><tab>]]
vim.cmd[[inoremap "<cr> "<cr>"<c-o><s-o><tab>]]

-- Backspace behavior
vim.cmd[[inoremap {<backspace> <Nop>]]
vim.cmd[[inoremap (<backspace> <Nop>]]
vim.cmd[[inoremap [<backspace> <Nop>]]
vim.cmd[[inoremap '<backspace> <Nop>]]
vim.cmd[[inoremap "<backspace> <Nop>]]

-- Weird right-to-left thing
-- vim.cmd[[inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"]]
-- vim.cmd[[inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"]]
-- vim.cmd[[inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"]]
-- vim.cmd[[inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "''<left>"]]
-- vim.cmd[[inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"<left>"]]

-- Skip closing on Escape
vim.cmd[[inoremap {<Esc> {]]
vim.cmd[[inoremap (<Esc> (]]
vim.cmd[[inoremap [<Esc> []]
vim.cmd[[inoremap '<Esc> ']]
vim.cmd[[inoremap "<Esc> "]]

-- Center space
vim.cmd[[inoremap {<space> {<space><space>}<left><left>]]
vim.cmd[[inoremap (<space> (<space><space>)<left><left>]]
vim.cmd[[inoremap [<space> [<space><space>]<left><left>]]
-- vim.cmd[[inoremap '<space> '<space><space>'<left><left>]]
-- vim.cmd[[inoremap "<space> "<space><space>"<left><left>]]

-- Normal mode closing
vim.cmd[[nnoremap ' mmbi'<esc>ea'<esc>`m<right>]]
vim.cmd[[nnoremap " mmbi"<esc>ea"<esc>`m<right>]]
vim.cmd[[nnoremap ( mmbi(<esc>ea)<esc>`m<right>]]
vim.cmd[[nnoremap { mmbi{<esc>ea}<esc>`m<right>]]
vim.cmd[[nnoremap [ mmbi[<esc>ea]<esc>`m<right>]]

-- Visual mode closing
vim.cmd[[vnoremap ' <Esc>`<i'<Esc>`>a<right>'<Esc>]]
vim.cmd[[vnoremap " <Esc>`<i"<Esc>`>a<right>"<Esc>]]
vim.cmd[[vnoremap ( <Esc>`<i(<Esc>`>a<right>)<Esc>]]
vim.cmd[[vnoremap { <Esc>`<i{<Esc>`>a<right>}<Esc>]]
vim.cmd[[vnoremap [ <Esc>`<i[<Esc>`>a<right>]<Esc>]]
