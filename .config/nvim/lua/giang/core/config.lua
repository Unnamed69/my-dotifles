vim.cmd(string.format([[highlight WinBar1 guifg=%s]], "#24EAF7"))
vim.cmd(string.format([[highlight WinBar2 guifg=%s]], "#44FFB1"))
-- Function to get the full path and replace the home directory with ~
local function get_winbar_path()
  local full_path = vim.fn.expand("%:p")
  return full_path:gsub(vim.fn.expand("$HOME"), "~")
end
-- Function to get the number of open buffers using the :ls command
local function get_buffer_count()
  local buffers = vim.fn.execute("ls")
  local count = 0
  -- Match only lines that represent buffers, typically starting with a number followed by a space
  for line in string.gmatch(buffers, "[^\r\n]+") do
    if string.match(line, "^%s*%d+") then
      count = count + 1
    end
  end
  return count
end
-- Function to update the winbar
local function update_winbar()
  if string.match(vim.bo.filetype, "^NvimTree") then
    vim.opt.winbar = nil -- Disable winbar for Nvim Tree
  else
    local home_replaced = get_winbar_path()
    local buffer_count = get_buffer_count()
    vim.opt.winbar = "%#WinBar1#%m "
      .. "%#WinBar2#("
      .. buffer_count
      .. ") "
      .. "%#WinBar1#"
      .. home_replaced
      .. "%*%=%#WinBar2#"
  end
end
-- Autocmd to update the winbar on BufEnter and WinEnter events
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = update_winbar,
})
