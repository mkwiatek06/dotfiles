vim.g.mapleader = " " -- Leader (mapped to space) [keep before bindings req. Leader]
require('shared')

-- ==> Keybinds :3 <==
vim.keymap.set('n', '<leader>m', '<cmd>echo "meow"<CR>', { desc = 'Meow :3' })
vim.keymap.set('n', '<leader>rr', '<cmd>redo<CR>', { desc = 'Redo' })
vim.keymap.set('n', '<leader>rc',
	'<cmd>luafile $MYVIMRC<CR><cmd>echo "Config reloaded"<CR>',
	{ desc = 'Reload config' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = "exit terminal mode with <Esc>" })
vim.keymap.set('n', '<Tab>', '<C-w>w', { desc = "Next window" })
vim.keymap.set('n', '<S-Tab>', '<C-w>W', { desc = "Previous window" })
vim.keymap.set('n', '<leader><Tab>',
	'<cmd>tabnext<CR>', { desc = "Next window" })
vim.keymap.set('n', '<leader><S-Tab>',
	'<cmd>tabprevious<CR>', { desc = "Previous window" })
vim.keymap.set('n', '<leader>tc', '<cmd>$tabnew<CR>', { desc = "Tab Create" })

vim.keymap.set('x', 'p', [["_dP]]) -- don't re-yank when replacing in visual mode

vim.keymap.set('n', '_', "<cmd>vertical resize -2<CR>", { desc = "V Resize -" })
vim.keymap.set('n', '+', "<cmd>vertical resize +2<CR>", { desc = "V Resize +" })
vim.keymap.set('n', '-', "<cmd>horizontal resize -2<CR>", { desc = "H Resize -" })
vim.keymap.set('n', '=', "<cmd>horizontal resize +2<CR>", { desc = "H Resize +" })

-- ==> Options :3 <==
-- User plugin options
CompilerWinSize = 15

-- Something Wild (vim command line autocomplete)
vim.o.wildmode = "full"
vim.o.wildoptions = "fuzzy,pum"
vim.o.pumheight = 10

-- IDE UI
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- ^ Relative to current line
vim.opt.cursorline = true -- Highlight line the cursor is on
vim.opt.termguicolors = true -- Better colors
vim.opt.fillchars = { eob = ' ' } -- end-of-buffer character
vim.opt.signcolumn = "yes" -- Always display column for diagnostics
vim.o.scrolloff = 4 -- Keep lines before / after cursor when scrolling

-- IDE Functions
vim.opt.completeopt = {'menuone', 'noselect', 'popup'}
vim.opt.mouse = 'a' -- Enable mouse
vim.opt.timeout = false

-- History
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
-- vim.opt.undofile = true
-- vim.opt.undodir = "/tmp"

-- seawch
vim.opt.incsearch = true -- Incremental search
vim.opt.ignorecase = true -- Ignore case
vim.opt.smartcase = true -- ^ Not when explicitly Capitalised

-- cuwsow :3
vim.opt.guicursor = {
	"n-v-sm:block",
	"i-ve:ver25",
	"r-o:hor20",
	"t:hor20",
	"c-ci-cr:hor20"
}
-- n - Normal mode
-- v - Visual mode
-- ve - Visual exclusive
-- o - Operator-pending mode
-- i - Insert mode
-- r - Replace mode
-- c - Command-line Normal (append) mode
-- ci - Command-line Insert mode
-- cr - Command-line Replace mode
-- sm - showmatch in Insert mode
-- t - Terminal mode
-- a - all modes


-- ==> Autocommands :3 <==
-- Highlight when yanking (copying) text.
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	callback = function()
		vim.hl.on_yank()
	end
})

-- ==> Built-in external packages :3 <==
vim.cmd('packadd! nohlsearch') -- conditionally turn off search highlighting

-- ==> External files :3 <==
require('colors')
require('colorpicker')
require('lsp')
require('statusline')
-- require('tabline')
require('autoclose')
require('treesitter')
require('ide-interface')
require('clipboawd')
require('netrw')
require('fzf')
require('compile')
-- require('commands')
require('indents')
require('startup')
require('diff')
