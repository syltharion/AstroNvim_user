return {
  "Kohirus/cppassist.nvim", -- C++ 辅助类
  -- event = "VeryLazy",
  lazy = true,
  opt = true,
  ft = { "h", "cpp", "hpp", "c", "cc", "cxx" },
  config = function() require("cppassist").setup() end,
}
