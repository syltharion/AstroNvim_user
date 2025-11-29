---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- event = "VeryLazy",
    lazy = true,
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        "markmap-cli",
        -- install language servers
        "lua-language-server",
        -- "cmake-language-server",
        "arduino-language-server",
        "clangd",
        "biome", --json
        "jdtls",
        "rust-analyzer",
        "marksman",
        -- install formatters
        "stylua",
        "prettierd", --markdown
        "clang-format",
        -- install debuggers
        "debugpy",
        "cpptools",
        "codelldb",
        "java-debug-adapter",
        "java-test",
        "bash-language-server",
        "cortex-debug",
        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
