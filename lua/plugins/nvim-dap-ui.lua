return {
  "rcarriga/nvim-dap-ui",
  -- event = "VeryLazy",
  lazy = true,
  opts = function(_, opts)
    opts.layouts = {
      {
        elements = {
          "scopes",
          "watches",
          "stacks",
          "breakpoints",
        },
        size = 0.2, -- 40 columns
        position = "left",
      },
      {
        elements = {
          "repl",
        },
        size = 0.25, -- 25% of total lines
        position = "bottom",
      },
      {
        elements = {
          "console",
        },
        size = 0.2,
        position = "right",
      },
    }
    return opts
  end,

  config = function(plugin, opts)
    -- run default AstroNvim nvim-dap-ui configuration function
    require "astronvim.plugins.configs.nvim-dap-ui"(plugin, opts)
    -- local tree = require "neo-tree"

    -- disable dap events that are created
    local dap = require "dap"
    dap.listeners.after.event_initialized.dapui_config = nil
    dap.listeners.before.event_terminated.dapui_config = nil
    dap.listeners.before.event_exited.dapui_config = nil
  end,
}
