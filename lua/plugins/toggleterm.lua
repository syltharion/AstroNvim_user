return {
  "akinsho/toggleterm.nvim",
  -- event = "VeryLazy",
  lazy = true,
  opts = function(_, opts)
    opts.direction = "float"
    opts.size = 50
    opts.scrollback = 200
    opts.float_opts = {
      border = "curved",
      width = 120, -- 加宽显示区域
      height = 40, -- 增加可视行数
    }
    return opts
  end,
}
