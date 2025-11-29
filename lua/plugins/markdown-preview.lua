---@type LazySpec
return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && yarn install",
  init = function() vim.g.mkdp_filetypes = { "markdown" } end,
  ft = { "markdown" },
  config = function()
    -- vim.g.mkdp_filetypes = { "markdown", "pandoc" }
    -- vim.g.mkdp_auto_start = 0
    -- vim.g.mkdp_auto_close = 1
    -- vim.g.mkdp_refresh_slow = 1
    -- vim.g.mkdp_open_to_the_world = 1
    -- vim.g.mkdp_browser = "firefox"
    vim.g.mkdp_preview_options = {
      -- disable_sync_scroll = 1,
      -- hide_yaml_meta = 1,
      sync_scroll_type = "middle",
    }
  end,
}
