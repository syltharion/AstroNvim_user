return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre", -- load on opening a buffer
  opts = function(_, opts)
    opts.current_line_blame = true
    return opts
  end,
}
