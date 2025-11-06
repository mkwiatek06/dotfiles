local user = os.getenv("USER")
TempDir = "/tmp/nvim." .. user .. "/"

vim.fn.jobstart({ "mkdir", "-p", TempDir }, {
    on_exit = function(_, code, _)
        if code ~= 0 then
            vim.notify("Failed to create temp directory", vim.log.levels.ERROR)
        else
            function Compile(compiler, perm)
                compiler['file'] = vim.api.nvim_buf_get_name(0)
                if not vim.loop.fs_stat(compiler.file) then
                    vim.notify("Compilation Failed for unsaved file.", vim.log.levels.WARN)
                    return
                end

                if perm then
                    local dir = vim.fn.expand("%:p:h") .. "/bin/"
                    if vim.fn.isdirectory(dir) == 1 then
                        compiler['output'] = dir .. vim.fn.expand("%:t:r")
                    else
                        vim.notify("Compilation Failed - No bin folder.", vim.log.levels.WARN)
                        return
                    end
                else
                    compiler['output'] = TempDir .. vim.fn.expand("%:t:r")
                end

                local parts = {} -- Handling different command order per-compiler
                for _, key in ipairs(compiler.order) do
                    if key == "cmd" then
                        table.insert(parts, compiler.cmd)
                    elseif key == "file" then
                        table.insert(parts, compiler.file)
                    elseif key == "flag" then
                        table.insert(parts, compiler.flag)
                    elseif key == "output" then
                        table.insert(parts, compiler.output)
                    end
                end

                local command = table.concat(parts, " ")
                local result = vim.fn.system(command)

                if vim.v.shell_error ~= 0 then
                    vim.notify("Compilation failed.\n" .. result, vim.log.levels.ERROR)
                    return
                end

                vim.fn.system("chmod +x " .. compiler.output)
                vim.cmd('botright 10sp term://' .. compiler.output)
            end
        end
    end
})
