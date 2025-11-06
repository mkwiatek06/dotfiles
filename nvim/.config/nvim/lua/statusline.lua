-- Custom status line :3

vim.opt.laststatus=2

Statusline = {}

local function indent()
        local tabChar
        local indentWidth
        local highlight

        if vim.bo.expandtab then
                tabChar = "Space"
                indentWidth = vim.bo.softtabstop
                highlight = "%#StatusLine#"
        else
                tabChar = "Tab"
                indentWidth = vim.bo.tabstop
		if vim.o.tabstop == 8 then
			highlight = "%#SLIndentLinux#"
			return "%#Separator# " .. highlight .. " " .. indentWidth .. " " .. tabChar ..
			" " .. "%#Separator# " .. "%#StatusLine#"
		else
			highlight = "%#StatusLine"
		end
	end

        return highlight .. indentWidth .. " " .. tabChar .. "%#StatusLine#"
end

Statusline.active = function()
        return table.concat {
                ' %t',
                ' %m',
                ' %r',
                '%=',
                '%y ',
		indent(),
                -- ' [%n]',
                ' %3p%%',
                ' %3l:%-2c '
        }
end

-- function Statusline.inactive()
-- 	return " %F"
-- end

-- function Statusline.short()
-- 	return ""
-- end

-- vim.api.nvim_exec([[
--         augroup StatusLine
--         au!
--         au WinEnter,BufEnter * if &filetype !=# 'netrw' && &filetype !=# 'dashboard' | setlocal statusline=%!v:lua.Statusline.active()
--         au WinLeave,BufLeave * if &filetype !=# 'netrw' && &filetype !=# 'dashboard' | setlocal statusline=%!v:lua.Statusline.inactive()
--         au WinEnter,BufEnter,FileType netrw,dashboard setlocal statusline=%!v:lua.Statusline.short()
--         augroup END
-- ]], false)

-- vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FileType" }, {
--   callback = function()
--     local ft = vim.bo.filetype
--     if ft == "dashboard" or ft == "netrw" then
--       -- vim.opt_local.statusline = "%!v:lua.Statusline.short()"
--       vim.opt_local.laststatus = 0
--       vim.opt_local.cmdheight = 0
--     else
--       vim.opt_local.statusline = "%!v:lua.Statusline.active()"
--       vim.opt_local.laststatus = 2
--       vim.opt_local.cmdheight = 1
--     end
--   end,
-- })
