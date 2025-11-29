return {
  "lervag/vimtex",
  -- event = "VeryLazy",
  lazy = true,
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "sioyek"
    vim.g.vimtex_quickfix_ignore_filters = {
      "Underfull",
      "Overfull",
      "specifier changed to",
      "Token not allowed in a PDF string",
      "LaTeX Warning: Float too large for page",
      "contains only floats",
      "LaTeX Warning: Citation",
      'Missing "author" in',
      "LaTeX Font Warning:",
      'Package option "final" no longer has any effect with minted v3+',
    }
  end,

}
