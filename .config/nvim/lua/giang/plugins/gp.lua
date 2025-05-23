return {
  "robitx/gp.nvim",
  config = function()
    require("gp").setup({
      providers = {
        openai = {
          disable = false,
          endpoint = "https://api.openai.com/v1/chat/completions",
          secret = { "op", "read", "op://Personal/Chat-GPT-API-key/credential", "--no-newline" },
        },
        anthropic = {
          disable = false,
          endpoint = "https://api.anthropic.com/v1/messages",
          secret = { "op", "read", "op://Personal/Claude-API-key/credential", "--no-newline" },
        },
        copilot = {
          endpoint = "https://api.githubcopilot.com/chat/completions",
          secret = {
            "bash",
            "-c",
            "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
          },
        },
      },
      agents = {
        {
          name = "ChatGPT4",
          provider = "openai",
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4o", temperature = 1.0, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "You are a general AI assistant.\n\n"
            .. "The user provided the additional info about how they would like you to respond:\n\n"
            .. "- If you're unsure don't guess and say you don't know instead.\n"
            .. "- Ask question if you need clarification to provide better answer.\n"
            .. "- Think deeply and carefully from first principles step by step.\n"
            .. "- Zoom out first to see the big picture and then zoom in to details.\n"
            .. "- Use Socratic method to improve your thinking and coding skills.\n"
            .. "- Don't elide any code from your output if the answer requires coding.\n"
            .. "- Take a deep breath; You've got this!\n",
        },
        {
          name = "CodeGPT4",
          provider = "openai",
          chat = false,
          command = true,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4o", temperature = 0.8, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "You are an AI working as a code editor.\n\n"
            .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
            .. "START AND END YOUR ANSWER WITH:\n\n```",
        },
        {
          provider = "anthropic",
          name = "ChatClaude-Sonnet",
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = "claude-3-7-sonnet-20250219", temperature = 0.8, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = require("gp.defaults").chat_system_prompt,
        },
        {
          provider = "anthropic",
          name = "CodeClaude-Sonnet",
          chat = false,
          command = true,
          -- string with model name or table with model name and parameters
          model = { model = "claude-3-7-sonnet-20250219", temperature = 0.8, top_p = 1 },
          system_prompt = require("gp.defaults").code_system_prompt,
        },
        {
          provider = "copilot",
          name = "ChatCopilot",
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4o", temperature = 0.8, top_p = 1, n = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = require("gp.defaults").chat_system_prompt,
        },
        {
          provider = "copilot",
          name = "CodeCopilot",
          chat = false,
          command = true,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4o", temperature = 0.8, top_p = 1, n = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = require("gp.defaults").code_system_prompt,
        },
      },
    })

    -- or setup with your own config (see Install > Configuration in Readme)
    -- require("gp").setup(config)

    -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    require("gp")._state.chat_agent = "ChatClaude-Sonnet"
    require("gp")._state.command_agent = "CodeClaude-Sonnet"
  end,
}
