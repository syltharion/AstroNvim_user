return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = true,
  -- event = "VeryLazy",
  lazy = true,
  ft = { "markdown","dbout" },
  opts = function(_, opts)
    opts.checkbox = {
      checked = { scope_highlight = "@markup.strikethrough" },
    }
    return opts
  end,
}
