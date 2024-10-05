return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    local utils = require("giang.core.utils")

    lualine.setup({
      options = {
        theme = "dracula",
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = "●",
            },
          },
          {
            function()
              local buffer_count = utils.get_buffer_count()

              return "+" .. buffer_count - 1 .. " "
            end,
            cond = function()
              return utils.get_buffer_count() > 1
            end,
            color = utils.get_hlgroup("Operator", { fg = "#ff9e64" }),
            padding = { left = 0, right = 1 },
          },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
