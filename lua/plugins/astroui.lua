return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function(_, opts)
      -- opts.background = { -- :h background
      --   light = "latte",
      --   dark = "frappe",
      -- }
      opts.transparent_background = true
      opts.show_end_of_buffer = true -- shows the '~' characters after the end of buffers
      opts.term_colors = true -- set the terminal colors to the neovim colors
      opts.styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      }
      opts.dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "light", -- the shading mode: 'dark' or 'light'
        percentage = 0.5, -- percentage of the shade to apply to the inactive window
      }
      return opts
    end,
  },
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      -- change colorscheme
      -- colorscheme = "astrodark",
      colorscheme = "catppuccin",
      -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
      highlights = {
        init = { -- this table overrides highlights in all themes
          -- Normal = { bg = "#000000" },
        },
        astrodark = { -- a table of overrides/changes when applying the astrotheme theme
          -- Normal = { bg = "#000000" },
        },
      },
      folding = {
        -- whether a buffer should have folding can be true/false for global enable/disable or fun(bufnr:integer):boolean
        enabled = function(bufnr)
          return require("astrocore.buffer").is_valid(bufnr)
        end,
        -- a priority list of fold methods to try using, available methods are "lsp", "treesitter", and "indent"
        methods = { "lsp", "treesitter", "indent" },
      },
      -- Icons can be configured throughout the interface
      icons = {
        -- configure the loading of the lsp in the status line
        LSPLoading1 = "⠋",
        LSPLoading2 = "⠙",
        LSPLoading3 = "⠹",
        LSPLoading4 = "⠸",
        LSPLoading5 = "⠼",
        LSPLoading6 = "⠴",
        LSPLoading7 = "⠦",
        LSPLoading8 = "⠧",
        LSPLoading9 = "⠇",
        LSPLoading10 = "⠏",
      },

      status = { -- astroui_lsp_client_names
        providers = {
          lsp_client_names = {
            mappings = {
              -- display `lua_ls` as just `LUA` in the statusline
              lua_ls = "LUA",
              copilot = "AI",
              clangd = "C/C++",
              ccls = "C/C++",
              clang_format = "C/C++",
              pyright = "PY",
              jsonls = "JSON",
              jdtls = "JAVA",
              rust_analyzer = "RUST",
              tsserver = "TS",
              html = "HTML",
              cssls = "CSS",
              bashls = "BASH",
              gopls = "GO",
              marksman = "MD",
              dockerls = "DOCKER",
            },
          },
        },
      },
    },
  },
}
