-- Netrw
function ToggleNetrw()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local cur_ft = vim.api.nvim_get_option_value("filetype", { buf = buf })

        if vim.api.nvim_buf_is_valid(buf) and vim.b[buf].is_fzf then
            vim.api.nvim_win_close(win, true)
        end

        -- If netrw is already open, close it (by default doesn't work with below config)
        if cur_ft == "netrw" then
            vim.api.nvim_win_close(win, true)
            return
        end
    end
    vim.cmd('Lexplore %:p:h')
end

vim.keymap.set('n', '<leader>ee', function()
    ToggleNetrw()
end, { desc = "Open netrw" })

vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20
vim.g.netrw_browse_split = 0
vim.g.netrw_fastbrowser = 0
vim.g.netrw_hide = 0 -- Show everything
vim.g.netrw_list_hide = 0
vim.g.netrw_keepdir = 0 -- Keep the cursor in the same place when moving between files (maybe)
vim.g.netrw_preview = 1 -- Preview files with 'p'
vim.g.netrw_sort_sequence = [[[\/]$,*]]
vim.g.netrw_sizestyle = "H"

if IsUnix == true then -- only on *nix systems
    vim.g.netrw_localcopydircmd = "cp -r"
    vim.g.netrw_localmkdir = "mkdir -p"
    vim.g.netrw_localrmdir = "rm -r"
end

-- In netrw, make `t` open file in background tab
vim.api.nvim_create_autocmd("filetype", {
    pattern = "netrw",
    callback = function()
    vim.keymap.set("n", "t", function()
        -- Get the file under cursor
        local file = vim.fn.expand("<cfile>")
        if file ~= "" then
            -- Open in new tab without switching to it
            vim.cmd("tabnew " .. vim.fn.fnameescape(file))
            vim.cmd("tabprevious")
        end
    end, { buffer = true, silent = true })
end,
})
