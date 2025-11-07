local compiler = {
    cmd = "rustc",
    flag = "-o",
    order = { "cmd", "file", "flag", "output" }
}

vim.keymap.set('n', '<leader>cc', function()
    Compile(compiler, false)
end, { buffer = true, desc = "Compile rust in tmpdir" })

vim.keymap.set('n', '<leader>cw', function()
    Compile(compiler, true)
end, { buffer = true, desc = "Compile rust in ./bin/" })
