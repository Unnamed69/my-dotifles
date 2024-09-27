return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-frecency.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    -- local transform_mod = require("telescope.actions.mt").transform_mod

    -- local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

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
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("frecency")
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope frecency workspace=CWD<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set(
      "n",
      "<leader>fs",
      "<cmd>Telescope live_grep sort_mru=true sort_lastused=true<cr>",
      { desc = "Find string in cwd" }
    )
    keymap.set(
      "n",
      "<leader>fc",
      "<cmd>Telescope grep_string sort_mru=true sort_lastused=true<cr>",
      { desc = "Find string under cursor in cwd" }
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
