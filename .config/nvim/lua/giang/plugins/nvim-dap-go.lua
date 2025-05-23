return {
  "leoluz/nvim-dap-go",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    local dapgo = require("dap-go")
    local dap_virtual_text = require("nvim-dap-virtual-text")
    dapui.setup()
    dapgo.setup()
    dap_virtual_text.setup()
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end

    -- Include the next few lines until the comment only if you feel you need it
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    -- Include everything after this

    vim.keymap.set("n", "<F5>", function()
      require("dap").continue()
    end)
    vim.keymap.set("n", "<F10>", function()
      require("dap").step_over()
    end)
    vim.keymap.set("n", "<F11>", function()
      require("dap").step_into()
    end)
    vim.keymap.set("n", "<F12>", function()
      require("dap").step_out()
    end)
    vim.keymap.set("n", "<Leader>q", function()
      require("dap").toggle_breakpoint()
    end)
    vim.keymap.set("n", "<Leader>Q", function()
      require("dap").set_breakpoint()
    end)
    vim.keymap.set("n", "<Leader>lp", function()
      require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end)
    vim.keymap.set("n", "<Leader>dr", function()
      require("dapui").open({ reset = true })
    end)
    vim.keymap.set("n", "<Leader>dl", function()
      require("dap").run_last()
    end)

    vim.keymap.set("n", "<Leader>w", function()
      dapui.open()
    end)
    vim.keymap.set("n", "<Leader>W", function()
      dapui.close()
    end)
  end,
}
