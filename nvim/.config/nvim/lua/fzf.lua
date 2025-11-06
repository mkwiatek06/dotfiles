-- Check for fzf
if vim.fn.executable('fzf') == 0 then
    error("No fzf executable found")
end

-- Fuzzy finder
function ToggleFzf()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local cur_ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
        -- local name = vim.api.nvim_buf_get_name(buf)

        -- If netrw is open, close it
        if cur_ft == "netrw" then
            vim.api.nvim_win_close(win, true)
        end

        if vim.api.nvim_buf_is_valid(buf) and vim.b[buf].is_fzf then
            vim.api.nvim_win_close(win, true)
            -- vim.cmd('echo meow')
            return
        end
    end

    -- local result = vim.fn.systemlist("fzf")

    vim.cmd("vert topleft 30vs | terminal fzf")
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_var(bufnr, "is_fzf", true)

    -- if result ~= nil and #result > 0 then
        -- vim.cmd("tabedit " .. vim.fn.fnameescape(result[1]))
    -- end

    -- vim.defer_fn(function()
    --     local chan = vim.b[bufnr].terminal_job_id
    --     vim.api.nvim_chan_send(chan, "\27[5 q")
    -- end, 50)
end

vim.keymap.set('n', '<leader>ef', function()
    ToggleFzf()
end, { desc = "Open fzf" })

function FullscreenFzf(startscreen)
	if startscreen then
		vim.cmd('q')
	end
	local scratch = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_current_buf(scratch)

	vim.fn.termopen('fzf', {
		on_exit = function(_, code, _)
			print('code: ', code)
			local lines = vim.api.nvim_buf_get_lines(scratch, 0, 1, false)
			local output = lines[1]

			vim.cmd('edit ' .. vim.fn.fnameescape(output))
		end
	})

	vim.cmd("startinsert")

    -- local bufnr = vim.api.nvim_get_current_buf()
    -- vim.api.nvim_buf_set_var(bufnr, "is_fzf", true)

    -- if result ~= nil and #result > 0 then
        -- vim.cmd("tabedit " .. vim.fn.fnameescape(result[1]))
    -- end

    -- vim.defer_fn(function()
    --     local chan = vim.b[bufnr].terminal_job_id
    --     vim.api.nvim_chan_send(chan, "\27[5 q")
    -- end, 50)
end
