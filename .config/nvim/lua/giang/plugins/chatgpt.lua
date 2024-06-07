return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    require("chatgpt").setup({
      api_key_cmd = "op read op://Personal/Chat-GPT-API-key/credential --no-newline",
      openai_edit_params = {
        model = "gpt-4-turbo",
      },
    })
  end,
}
