-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "c",
      "cpp",
      "java",
      "diff",
      "cmake",
      "python",
      "lua",
      "vim",
      "jsonc",
      "regex",
      "css",
      "javascript",
      "latex",
      "norg",
      "scss",
      "svelte",
      "tsx",
      "typst",
      "vue",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
