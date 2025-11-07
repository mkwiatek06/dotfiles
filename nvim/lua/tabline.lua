-- Always show tabline
vim.o.showtabline = 1

-- Define a custom tabline renderer
function _G.my_tabline()
  local s = ""
  local tab_count = vim.fn.tabpagenr("$")

  for i = 1, tab_count do
    local winnr = vim.fn.tabpagewinnr(i)
    local buflist = vim.fn.tabpagebuflist(i)
    local bufnr = buflist[winnr]
    local name = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":t")
    if name == "" then name = "[No Name]" end

    if i == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#" .. " " .. i .. " " .. name .. " "
    else
      s = s .. "%#TabLine#" .. " " .. i .. " " .. name .. " "
    end
  end

  s = s .. "%#TabLineFill#"
  return s
end

-- Hook it up
vim.o.tabline = "%!v:lua.my_tabline()"
