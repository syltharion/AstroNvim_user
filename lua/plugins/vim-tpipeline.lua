-- Embed your vim statusline in tmux
return {
  "vimpostor/vim-tpipeline",
  -- event = "VeryLazy",
  lazy = true,
  enabled = true,
  config = function()
    vim.g.tpipeline_autoembed = 1
    vim.g.tpipeline_restore = 1
    vim.g.tpipeline_clearstl = 1
  end,
}
