-- Treesitter :3
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Treesitter :3',
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end
})

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

vim.keymap.set('n', '<leader>ze', '<cmd>foldopen<CR>', { desc = '[FLD] Open fold' })
-- [<leader> + zc] already mapped as combination of default

function _G.TSIndentExpr()
        local row = vim.fn.line('.') - 1
        local col = 0
        local parser = vim.treesitter.get_parser(0)
        if not parser then return -1 end

        local tree = parser:parse()[1]
        local root = tree:root()

        local node = root:named_descendant_for_range(row, col, row, col)
        if not node then return -1 end

        while node do
                local start_row = node:start()
                if start_row < row then
                        local id = node:id()
                        local query = vim.treesitter.query.get(vim.bo.filetype, "indents")
                        if query then
                                for _, cap, _ in query:iter_captures(node, 0, start_row, start_row + 1) do
                                if cap == "indents.begin" then
                                        local sw = vim.bo.shiftwidth > 0 and vim.bo.shiftwidth or vim.bo.tabstop
                                        return vim.fn.indent(start_row + 1) + sw
                                end
                        end
                end
        end
        node = node:parent()
end
return vim.fn.indent(vim.fn.prevonblank(row))
end

vim.cmd('echo "TreeSitter Deactivated!"')

vim.bo.smartindent = true
vim.bo.cindent = true
vim.bo.autoindent = true

-- vim.bo.indentexpr = "v:lua.TSIndentExpr()"
