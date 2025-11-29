return {
  "p00f/clangd_extensions.nvim", -- install lsp plugin
  event = "BufReadPre *.c,*.cpp,*.h,*.hpp", -- load on c/c++ files
  opts = function(_, opts)
    opts.ast = {
      -- 这些设置会让 CodeLens 显示更多信息
      role_icons = {
        type = "🄣",
        declaration = "🄓",
        expression = "🄔",
        statement = ";",
        specifier = "🄢",
        ["template argument"] = "🆃",
      },
      kind_icons = {
        Compound = "🄲",
        Recovery = "🅁",
        TranslationUnit = "🅄",
        PackExpansion = "🄿",
        TemplateTypeParm = "🅃",
        TemplateTemplateParm = "🅃",
        TemplateParamObject = "🅃",
      },
      highlights = {
        detail = "Comment",
      },
    }
    opts.memory_usage = {
      border = "none",
    }
    opts.symbol_info = {
      border = "none",
    }
    return opts
  end,
}
