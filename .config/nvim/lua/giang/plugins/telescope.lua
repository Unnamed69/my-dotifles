return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    -- local transform_mod = require("telescope.actions.mt").transform_mod

    -- local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")
    local lga_actions = require("telescope-live-grep-args.actions")
    -- or create your custom action
    -- local custom_actions = transform_mod({
    --   open_trouble_qflist = function(prompt_bufnr)
    --     trouble.toggle("quickfix")
    --   end,
    -- })

    telescope.setup({
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--sortr=modified" },
        },
      },
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-t>"] = trouble_telescope.open,
            ["<ESC>"] = actions.close,
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["d"] = actions.delete_buffer,
            ["q"] = actions.close,
          },
        },
      },
      extensions = {
        frecency = {
          show_scores = true,
          show_filter_columns = false,
        },
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = { -- extend mappings
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              -- freeze the current list and start a fuzzy search in the frozen list
              ["<C-space>"] = actions.to_fuzzy_refine,
            },
          },
          -- ... also accepts theme settings, for example:
          -- theme = "dropdown", -- use dropdown theme
          -- theme = { }, -- use own theme spec
          -- layout_config = { mirror=true }, -- mirror preview pane
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("frecency")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("noice")
    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
    keymap.set("n", "<leader>ff", "<cmd>Telescope frecency workspace=CWD<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set(
      "n",
      "<leader>fs",
      "<cmd>Telescope live_grep sort_mru=true sort_lastused=true<cr>",
      { desc = "Find string in cwd" }
    )
    keymap.set(
      "v",
      "<leader>fc",
      "<cmd>Telescope grep_string sort_mru=true sort_lastused=true<cr>",
      { desc = "Find string under cursor in cwd" }
    )
    keymap.set(
      "n",
      "<leader>fv",
      live_grep_args_shortcuts.grep_visual_selection,
      { desc = "Find string in visual selection" }
    )
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set(
      "n",
      "<leader>fb",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      { desc = "Fuzzy find buffers" }
    )
  end,
}
