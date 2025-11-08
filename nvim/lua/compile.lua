-- Keybinds for compilation are in after/ftplugins

TmpOK = false
if vim.loop.os_uname().sysname == "Linux" then
	OS = "Linux"
end

if OS == "Linux" then
	local user = os.getenv("USER")
	TempDir = "/tmp/nvim." .. user .. "/"

	vim.fn.jobstart({ "mkdir", "-p", TempDir }, {
		on_exit = function(_, code, _)
			if code == 0 then
				TmpOK = true
			end
		end
	})
end

function Compile(compiler_param, tmp)
	compiler_param['file'] = vim.api.nvim_buf_get_name(0)
	if not vim.loop.fs_stat(compiler_param.file) then
		vim.notify("Compilation Failed for unsaved file.", vim.log.levels.WARN)
		return
	end

	if tmp then
		compiler_param['output'] = TempDir .. vim.fn.expand("%:t:r")
	else
		local dir = vim.fn.expand("%:p:h") .. "/bin/"
		if vim.fn.isdirectory(dir) then
			compiler_param['output'] = dir .. vim.fn.expand("%:t:r")
		else
			vim.notify("Compilation Failed - No bin folder.", vim.log.levels.WARN)
			return
		end

	end

	local command = {} -- Handling different command order per-compiler
	for _, key in ipairs(compiler_param.order) do
		if key == "cmd" then
			table.insert(command, compiler_param.cmd)
		elseif key == "file" then
			table.insert(command, compiler_param.file)
		elseif key == "flag" then
			table.insert(command, compiler_param.flag)
		elseif key == "output" then
			table.insert(command, compiler_param.output)
		end
	end

	local result = vim.fn.system(table.concat(command, " "))

	if vim.v.shell_error ~= 0 then
		vim.notify("Compilation failed.\n" .. result, vim.log.levels.ERROR)
		return
	end

	if OS == "Linux" then
		vim.fn.system("chmod +x " .. compiler_param.output)
	end
	vim.cmd("botright " .. CompilerWinSize .. "sp term://" .. compiler_param.output)
end
