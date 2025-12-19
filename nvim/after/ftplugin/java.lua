local compiler = {
    cmd = "javac",
    flag = "-d",
    order = { "cmd", "flag", "output", "file" },
    output_is_dir = true,
    runner = "java"
}

vim.keymap.set('n', '<leader>cc', function()
    Compile(compiler, true)
end, { buffer = true, desc = "Compile Java in tmpdir" })

vim.keymap.set('n', '<leader>cw', function()
    Compile(compiler, false)
end, { buffer = true, desc = "Compile Java in ./bin/" })
