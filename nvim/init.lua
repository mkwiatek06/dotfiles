-- ==> Keybinds :3 <==
vim.g.mapleader = " " -- Leader (mapped to space) [keep before bindings req. Leader]
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

if vim.fn.has("unix") then
	OS = "unix"
elseif vim.fn.has("win32") then
	OS = "win32"
end

-- ==> Options :3 <==
-- Something Wild
vim.o.wildmode = longest, list
vim.o.wildoptions = fuzzy

-- IDE UI
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = false -- ^ Relative to current line
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

-- Auto close netrw and diagnostics windows when quitting the last "real" buffer [AI :3]
vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		local invalid_win = {}
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			-- local bt = vim.api.nvim_get_option_value("buftype", { buf = buf })
			local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })

			-- mark netrw or diagnostic windows for closing
			if ft == "netrw" or ft == "qf" then
				table.insert(invalid_win, win)
			end
		end

		-- if we’re about to quit and only these remain, close them
		if #invalid_win == #vim.api.nvim_list_wins() - 1 then
			for _, win in ipairs(invalid_win) do
				vim.api.nvim_win_close(win, true)
			end
		end
end,
})

-- ==> Built-in external packages :3 <==
vim.cmd('packadd! nohlsearch') -- conditionally turn off search highlighting

-- ==> External files :3 <==
require('colors')
require('lsp')
require('statusline')
-- require('tabline')
require('autoclose')
require('treesitter')
require('ide-interface')
require('clipboawd')
require('netrw')
require('fzf')
if OS == "unix" then
	require('compile-ng')
end
-- require('commands')
require('indents')
require('startup')
