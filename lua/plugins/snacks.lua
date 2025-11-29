return {
  "folke/snacks.nvim",
  event = "VeryLazy",
  priority = 1000,
  lazy = false,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local Snacks = require "snacks"
        maps.n["]r"] = { function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference" }
        maps.n["[r"] = { function() Snacks.words.jump(-vim.v.count1) end, desc = "Previous reference" }
        maps.n["<Leader>ur"] = {
          function()
            if Snacks.words.is_enabled() then
              Snacks.notify "Reference highlighting off" -- notify when disabling
              Snacks.words.disable()
            else
              Snacks.notify "Reference highlighting on" -- notify when enabling
              Snacks.words.enable()
            end
          end,
          desc = "Toggle reference highlighting (buffer)",
        }
        maps.n["<Leader>uR"] = {
          function()
            Snacks.notify "Clean references highlighting" -- notify when disabling
            if Snacks.words.is_enabled() then Snacks.words.clear() end
          end,
          desc = "Clean reference highlighting",
        }
      end,
    },
  },
  opts = function(_, opts)
    opts.dashboard = {
      enabled = true,
      preset = {
        header = table.concat({
          "███    ██ ██    ██ ██ ███    ███",
          "████   ██ ██    ██ ██ ████  ████",
          "██ ██  ██ ██    ██ ██ ██ ████ ██",
          "██  ██ ██  ██  ██  ██ ██  ██  ██",
          "██   ████   ████   ██ ██      ██",
        }, "\n"),
      },
    }
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- opts.animate = {}
    --   opts.bufdelete = {}
    --   opts.debug = {}
    --   opts.dim = {}
    opts.image = {

      formats = {
        "png",
        "jpg",
        "jpeg",
        "gif",
        "bmp",
        "webp",
        "tiff",
        "heic",
        "avif",
        "mp4",
        "mov",
        "avi",
        "mkv",
        "webm",
        "pdf",
      },
      force = true, -- try displaying the image, even if the terminal does not support it
      doc = {
        -- enable image viewer for documents
        -- a treesitter parser must be available for the enabled languages.
        enabled = true,
        -- render the image inline in the buffer
        -- if your env doesn't support unicode placeholders, this will be disabled
        -- takes precedence over `opts.float` on supported terminals
        inline = true,
        -- render the image in a floating window
        -- only used if `opts.inline` is disabled
        float = true,
        max_width = 40,
        max_height = 20,
        -- Set to `true`, to conceal the image text when rendering inline.
        -- (experimental)
        ---@param lang string tree-sitter language
        ---@param type snacks.image.Type image type
        conceal = function(lang, type)
          -- only conceal math expressions
          return type == "math"
        end,
      },
      img_dirs = {
        "img",
        "images",
        "assets",
        "static",
        "public",
        "media",
        "attachments",
      },
      -- window options applied to windows displaying image buffers
      -- an image buffer is a buffer with `filetype=image`
      wo = {
        wrap = false,
        number = false,
        relativenumber = false,
        cursorcolumn = false,
        signcolumn = "no",
        foldcolumn = "0",
        list = false,
        spell = false,
        statuscolumn = "",
      },

      cache = vim.fn.stdpath "cache" .. "/snacks/image",
      debug = {
        request = false,
        convert = false,
        placement = false,
      },
      env = {},
      -- icons used to show where an inline image is located that is rendered below the text.
      icons = {
        math = "󰪚 ",
        chart = "󰄧 ",
        image = " ",
      },
      ---@class snacks.image.convert.Config
      convert = {
        notify = true, -- show a notification on error
        ---@type snacks.image.args
        mermaid = function()
          local theme = vim.o.background == "light" and "neutral" or "dark"
          return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}" }
        end,
        ---@type table<string,snacks.image.args>
        magick = {
          default = { "{src}[0]", "-scale", "1920x1080>" }, -- default for raster images
          vector = { "-density", 192, "{src}[0]" }, -- used by vector images like svg
          math = { "-density", 192, "{src}[0]", "-trim" },
          pdf = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
        },
      },
      math = {
        enabled = true, -- enable math expression rendering
        -- in the templates below, `${header}` comes from any section in your document,
        -- between a start/end header comment. Comment syntax is language-specific.
        -- * start comment: `// snacks: header start`
        -- * end comment:   `// snacks: header end`
        typst = {
          tpl = [[
        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 12pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
        },

        latex = {
          font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
          -- for latex documents, the doc packages are included automatically,
          -- but you can add more packages here. Useful for markdown documents.
          packages = { "ctex", "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
          tpl = [[
    \documentclass[preview,border=2pt,varwidth=1024pt,12pt]{standalone}
    \usepackage{${packages}}
    \begin{document}
    ${header}
    { \${font_size} \selectfont
      \color[HTML]{${color}}
    ${content}}
    \end{document}]],
        },
      },
    }
    opts.lazygit = {}
    --   opts.git = {}
    --   opts.gitbrowse = {}
    --   opts.layout = {}
    --   opts.notify = {}
    --   opts.profiler = {}
    --   opts.rename = {}
    --   opts.util = {}
    --   opts.win = {}
    --   opts.zen = {}
    --   opts.terminal = {}
    --   opts.scratch = {}
    --   opts.bigfile = { enabled = true }
    -- opts.explorer = { enabled = true }
    -- opts.indent = { enabled = true }
    --   opts.input = { enabled = true }
    --   opts.picker = { enabled = true }
    --   opts.notifier = { enabled = true }
    --   opts.quickfile = { enabled = true }
    --   opts.scope = { enabled = true }
    --   opts.scroll = { enabled = true }
    --   opts.statuscolumn = { enabled = true }
    --   opts.words = { enabled = true } -- 引用跳转，原生有支持
    ---@class snacks.words.Config
    ---@field enabled? boolean
    opts.words = {
      enabled = true, -- enable the snacks.words module
      debounce = 100, -- time in ms to wait before updating
      notify_jump = true, -- show a notification when jumping
      notify_end = true, -- show a notification when reaching the end
      foldopen = true, -- open folds after jumping
      jumplist = true, -- set jump point before jumping
      modes = { "n", "i", "c" }, -- modes to show references
      filter = function(buf) -- what buffers to enable `snacks.words`
        return vim.g.snacks_words ~= false and vim.b[buf].snacks_words ~= false
      end,
    }
    return opts
  end,
}
