return {
  "rest-nvim/rest.nvim",
  -- event = "VeryLazy",
  lazy = true,
  opts = function(_, opts)
    -- opts.rocks.hererocks =true
    -- opts.rocks.enabled =true
    return opts
  end,
}
