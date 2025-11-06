local user = os.getenv("USER")
TempDir = "/tmp/nvim." .. user .. "/"

vim.fn.jobstart({ "mkdir", "-p", TempDir }, {
    on_exit = function(_, code, _)
        if code ~= 0 then
            vim.notify("Failed to create temp directory", vim.log.levels.ERROR)
        else
            vim.keymap.set('n', '<leader>cc', function()
                Compile(vim.bo.filetype, false)
            end, { desc = "Compile program in tmpdir" })
        end
    end
})

vim.keymap.set('n', '<leader>cw', function()
    Compile(vim.bo.filetype, true)
end, { desc = "Compile program in ./bin/" })

local compiler = {
    c = {
        cmd = "clang",
        flag = "-o",
        order = { "cmd", "file", "flag", "output" },
    },
    cpp = {
        cmd = "clang++",
        flag = "-o",
        order = { "cmd", "file", "flag", "output" },
    },
    rust = {
        cmd = "rustc",
        flag = "-o",
        order = { "cmd", "file", "flag", "output" },
    },
    go = {
        cmd = "go build",
        flag = "-o",
        order = { "cmd", "flag", "output", "file" },
    },
}

function Compile(lang, perm)
    local cfg = compiler[lang]

    cfg['file'] = vim.api.nvim_buf_get_name(0)
    if not vim.loop.fs_stat(cfg.file) then
        vim.notify("Compilation Failed for unsaved file.", vim.log.levels.WARN)
        return
    end

    if perm then
        local dir = vim.fn.expand("%:p:h") .. "/bin/"
        if vim.fn.isdirectory(dir) == 1 then
            cfg['output'] = dir .. vim.fn.expand("%:t:r")
        else
            vim.notify("Compilation Failed - Folder error.", vim.log.levels.ERROR)
        end
    else
        cfg['output'] = TempDir .. vim.fn.expand("%:t:r")
        -- vim.notify(cfg['output'], vim.log.levels.WARN)
    end

    local parts = {}
    for _, key in ipairs(cfg.order) do
        if key == "cmd" then
            table.insert(parts, cfg.cmd)
        elseif key == "file" then
            table.insert(parts, cfg.file)
        elseif key == "flag" then
            table.insert(parts, cfg.flag)
        elseif key == "output" then
            table.insert(parts, cfg.output)
        end
    end

    local command = table.concat(parts, " ")
    local result = vim.fn.system(command)

    if vim.v.shell_error ~= 0 then
        vim.notify("Compilation failed.\n" .. result, vim.log.levels.ERROR)
        return
    end

    vim.fn.system("chmod +x " .. cfg.output)
    -- vim.fn.jobstart(cfg.output, { detach = false })
    vim.cmd('botright 10sp term://' .. cfg.output)
end
