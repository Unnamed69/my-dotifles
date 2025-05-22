return {
  "petertriho/nvim-scrollbar",
  requires = { "catppuccin/nvim", "lewis6991/gitsigns.nvim", "kevinhwang91/nvim-hlslens" },
  config = function()
    local colors = require("catppuccin.palettes").get_palette("mocha")
    require("gitsigns").setup()
    require("scrollbar.handlers.gitsigns").setup()

    require("scrollbar").setup({
      handle = {
        color = colors.overlay1,
      },
      marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
        GitAdd = { color = colors.green },
        GitChange = { color = colors.yellow },
        GitDelete = { color = colors.red },
      },
    })
  end,
}
