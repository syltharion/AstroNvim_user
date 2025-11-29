return {
  "anurag3301/nvim-platformio.lua",
  -- event = "VeryLazy",
  enabled = false,
  lazy = true,
  dependencies = {
    -- { "akinsho/nvim-toggleterm.lua" }, --已经存在另外一个插件
    -- { "nvim-telescope/telescope.nvim" },
    { "nvim-lua/plenary.nvim" },
  },
  opts = function(_, opts)
    opts.lsp = "clangd" --default: ccls, other option: clangd
    -- If you pick clangd, it also creates compile_commands.json
    return opts
  end,
}
