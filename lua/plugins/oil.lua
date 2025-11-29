return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = function(_, opts)
    opts.default_file_explorer = true
    return opts
  end,
}
