return {
  "robitx/gp.nvim",
  config = function()
    require("gp").setup({
      openai_api_key = { "op", "read", "op://Personal/Chat-GPT-API-key/credential", "--no-newline" },
    })

    -- or setup with your own config (see Install > Configuration in Readme)
    -- require("gp").setup(config)

    -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
  end,
}
