vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.showtabline = 1
    if string.match(vim.bo.filetype, "^NvimTree") then
      vim.opt.winbar = nil -- Disable winbar for Nvim Tree
    end
  end,
})
require("giang.core")
require("giang.lazy")
