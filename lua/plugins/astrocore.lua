-- Source: https://www.reddit.com/r/neovim/comments/1fzn1zt/custom_fold_text_function_with_treesitter_syntax/
local function fold_virt_text(result, start_text, lnum)
  local text = ""
  local hl
  for i = 1, #start_text do
    local char = start_text:sub(i, i)
    local captured_highlights = vim.treesitter.get_captures_at_pos(0, lnum, i - 1)
    local outmost_highlight = captured_highlights[#captured_highlights]
    if outmost_highlight then
      local new_hl = "@" .. outmost_highlight.capture
      if new_hl ~= hl then
        -- as soon as new hl appears, push substring with current hl to table
        table.insert(result, { text, hl })
        text = ""
        hl = nil
      end
      text = text .. char
      hl = new_hl
    else
      text = text .. char
    end
  end
  table.insert(result, { text, hl })
end
function _G.custom_foldtext()
  local start_text = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
  local nline = vim.v.foldend - vim.v.foldstart
  local result = {}
  fold_virt_text(result, start_text, vim.v.foldstart - 1)
  table.insert(result, { " ... ↙ " .. nline .. " lines", "DapBreakpointCondition" })
  return result
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    copyindent = false, -- copy the previous indentation on autoindenting
    autoindent = false, -- maintain indent from previous line
    -- Configure core features of AstroNvim
    sessions = {
      -- Configure auto saving
      autosave = {
        last = false, -- auto save last session
        cwd = false, -- auto save session for each working directory
      },
      -- Patterns to ignore when saving sessions
      ignore = {
        dirs = {}, -- working directories to ignore sessions in
        filetypes = { "gitcommit", "gitrebase" }, -- filetypes to ignore sessions
        buftypes = {}, -- buffer types to ignore sessions
      },
    },
    features = {
      large_buf = { size = 1024 * 1024, lines = 20000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
      update_in_insert = false, --false输入的时候不要报错
    },
    -- vim options can be configured here
    options = {
      opt = {
        -- vim.opt.<key>
        foldcolumn = "0", -- '0' is not bad
        foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
        foldlevelstart = 99,
        foldenable = true,
        foldmethod = "expr",
        fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
        foldtext = "v:lua.custom_foldtext()", -- 自定义折叠文本
        -- guicursor = "n:block-blinkon10,i-ci:ver15-blinkon10,c:hor15-blinkon10,v-sm:block,ve:ver15,r-cr-o:hor10", --光标闪烁方式
        clipboard = "unnamedplus", -- 允许使用系统剪贴板
        encoding = "utf-8",
        fileencoding = "utf-8", -- 文件编码
        fileencodings = "utf8,ucs-bom,gb18030,gbk,gb2312,cp936,latin1", -- 文件支持编码
        expandtab = true,
        tabstop = 4, -- defalut 2
        -- shiftwidth = 4, -- defalut 2
        -- softtabstop = 4,
        -- cmdheight = 0,
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap (自动换行)
        -- 1  " 每个可隐藏的文本块会被替换为一个字符
        -- 2  " 可隐藏的文本会被完全隐藏，除非它有替换字符
        -- 3  " 可隐藏的文本会被完全隐藏
        conceallevel = 2,
        jumpoptions = "stack", -- sets vim.opt.jumpoptions
        mouse = "", --禁用鼠标会导致tmux窗口切换时出问题
        splitkeep = "cursor", -- 当使用 Ctrl-w j/k 时，光标保持在同一列
        backup = false, -- prohibit backup file
        -- scrolloff = 8, -- 光标上下保留8行
        title = true, -- 设置窗口标题
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        python3_host_prog = "python3",
        python_host_prog = "python3",
        loaded_perl_provider = 0,
        loaded_ruby_provider = 0,

        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized

    mappings = {
      x = {
        ["<Leader>/"] = false, -- gcc
      },
      -- first key is the mode
      n = {
        ["<Leader>w"] = false, -- there is already saved when file was changed.
        ["<Leader>q"] = false, -- no requirement.
        ["<Leader>Q"] = false, -- no requirement.
        -- 禁用 <Leader>/
        ["<Leader>/"] = false, -- gcc

        -- ["<F7>"] = { "<Cmd>OverseerRun Run\\ C/C++\\ file<CR>", desc = "Compile and run" },
        ["<Leader>tl"] = false,
        ["<Leader>dU"] = { function() require("dapui").open { reset = true } end, desc = "Restore Dap-UI" },
        ["<Leader>dG"] = { function() require("utils").create_launch_json() end, desc = "Create dap launch json" },
        ["<Leader>dQ"] = {
          function()
            require("dap").terminate()
            require("dapui").close()
          end,
          desc = "Terminate Session (S-F5)",
        },

        -- ["<Leader>dc"] = { function() require("dap").continue() end, desc = "Start/Continue (F5)" },

        -- 悬浮窗打开
        ["<Leader>dR"] = {
          function()
            require("dapui").float_element("repl", { position = "center", enter = true, width = 99, height = 99 })
          end,
          desc = "Toggle REPL",
        },

        -- ["<Leader>|"] = { "<Cmd>vsplit<CR>", desc = "Vertical Split" },
        -- ["<Leader>-"] = { "<Cmd>split<CR>", desc = "Horizontal Split" },
        -- setting a mapping to false will disable it
        -- ["|"] = false,
        -- ["\\"] = false,
        -- ["<leader>lw"] = false,  -- switch to header file on cpp

        -- ["<leader>C"] = false, --Force close buffer
        -- ["<Leader>C"] = { desc = "CMake" },

        ["<M-k>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
        ["<M-j>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
        ["<M-h>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
        ["<M-l>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },
        -- 禁用默认快捷键
        ["<C-Up>"] = false,
        ["<C-Down>"] = false,
        ["<C-Left>"] = false,
        ["<C-Right>"] = false,

        ["<C-'>"] = false,
        -- ["<Leader>Q"] = false,
        -- ["<Leader>q"] = false,
        ["<C-\\>"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle terminal" },

        ["<Leader>ls"] = false, -- gO
        ["<C-w>d"] = false, -- gO
        ["<Leader>ld"] = false, -- gl
      },

      t = {
        ["<C-\\>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
        ["<C-'>"] = false,
      },

      i = {
        ["<C-\\>"] = { "<Esc><Cmd>ToggleTerm direction=float<CR>", desc = "Toggle terminl" },
        ["<C-'>"] = false,
      },
    },
  },
}
