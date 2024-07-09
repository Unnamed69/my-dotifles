return {
  "petertriho/nvim-scrollbar",
  requires = { "folke/tokyonight.nvim", "lewis6991/gitsigns.nvim", "kevinhwang91/nvim-hlslens" },
  config = function()
    local colors = require("tokyonight.colors").setup()
    require("gitsigns").setup()
    require("scrollbar.handlers.gitsigns").setup()

    require("scrollbar").setup({
      handle = {
        color = colors.bg_highlight,
      },
      marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
        GitAdd = { color = colors.git.add },
        GitChange = { color = colors.git.change },
        GitDelete = { color = colors.git.delete },
      },
    })
  end,
}
