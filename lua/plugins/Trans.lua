return {
  "JuanZoran/Trans.nvim",
  -- event = "VeryLazy",
  lazy = true,
  build = function() require("Trans").install() end,
  dependencies = { "kkharji/sqlite.lua" },
  opts = function(_, opts)
    opts.debug = true
    opts.frontend = {
      default = {
        title = vim.fn.has "nvim-0.9" == 1 and {
          { "", "TransTitleRound" },
          { "Translation", "TransTitle" },
          { "", "TransTitleRound" },
        } or nil, -- need nvim-0.9+
        auto_play = false,
      },
      hover = {
        auto_resize = true,
        order = {
          default = {
            "translation",
          },
          offline = {
            "translation",
          },
          youdao = {
            "translation",
          },
        },
      },
    }
    return opts
  end,
  keys = { { "<leader>ts", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = "󰊿 Translate" } },
}
