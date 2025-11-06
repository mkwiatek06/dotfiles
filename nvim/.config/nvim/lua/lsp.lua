-- LSP :3
-- The servers below need to be installed
-- for the individual components to work.
-- Per-server configs can be found in
-- <NVim config folder>/lsp/

local servers = {
    'bash_ls',
    'clangd',
    'deno',
    'jedi_ls',
    'lua_ls',
    'rust_analyzer',
    'vsc_html_ls'
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

function ToggleLoclist()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local cur_ft = vim.api.nvim_get_option_value("filetype", { buf = buf })

        -- If a location list is already open, close it (by default only works when focused)
        if cur_ft == "qf" then
            vim.api.nvim_win_close(win, true)
            return
        end
    end
    -- Otherwise, open diagnostics in a location list
    vim.diagnostic.setloclist()
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = false })

        vim.keymap.set('n', '<leader>qq', vim.diagnostic.open_float, { desc = '[LSP] Open floating' }) -- Quickfix
        vim.keymap.set('n', '<leader>qk', vim.diagnostic.goto_prev, { desc = '[LSP] Go to previous' }) -- Quickfix up
        vim.keymap.set('n', '<leader>qj', vim.diagnostic.goto_next, { desc = '[LSP] Go to next' }) -- Quickfix down
        vim.keymap.set('n', '<leader>qe', ToggleLoclist, { desc = '[LSP] Show list' }) -- Quickfix Expand

        vim.keymap.set('n', '<leader>qrn', vim.lsp.buf.rename, { buffer = ev.buf }) -- Quickfix ReName
        vim.keymap.set('n', '<leader>qf', vim.lsp.buf.code_action, { buffer = ev.buf }) -- QuickFix action
        vim.keymap.set('n', '<leader>qrr', vim.lsp.buf.references, { buffer = ev.buf }) -- Quickfix RefeRences
        vim.keymap.set('n', '<leader>qi', vim.lsp.buf.implementation, { buffer = ev.buf }) -- Quickfix Implementation
        vim.keymap.set('n', '<leader>qO', vim.lsp.buf.document_symbol, { buffer = ev.buf }) -- Quickfix dOcument
        vim.keymap.set('n', '<leader>qi', vim.lsp.buf.signature_help, { buffer = ev.buf }) -- Quickfix sIgnature
    end,
})
