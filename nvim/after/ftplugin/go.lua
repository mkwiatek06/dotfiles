local compiler = {
    cmd = "go build",
    flag = "-o",
    order = { "cmd", "flag", "output", "file" },
}

vim.keymap.set('n', '<leader>cc', function()
    Compile(compiler, false)
end, { buffer = true, desc = "Compile go in tmpdir" })

vim.keymap.set('n', '<leader>cw', function()
    Compile(compiler, true)
end, { buffer = true, desc = "Compile go in ./bin/" })
