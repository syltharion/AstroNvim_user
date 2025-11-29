-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.code-runner.overseer-nvim" },
  -- { import = "astrocommunity.code-runner.sniprun" }, -- can't receive user input from stdin
  -- { import = "astrocommunity.code-runner.compiler-nvim" },
  { import = "astrocommunity.recipes.picker-lsp-mappings" },
  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  -- { import = "astrocommunity.recipes.telescope-nvim-snacks" },
  -- { import = "astrocommunity.recipes.ai" },
  { import = "astrocommunity.utility.lua-json5" },
  { import = "astrocommunity.utility.neodim" }, --nvim v0.10.0
  { import = "astrocommunity.utility.live-server-nvim" },
  -- { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.media.vim-wakatime" },
  -- { import = "astrocommunity.media.img-clip-nvim" }, -- ssh unsupport
  { import = "astrocommunity.file-explorer/oil-nvim" },
  -- { import = "astrocommunity.fuzzy-finder.snacks-picker" },
  { import = "astrocommunity.indent.snacks-indent-hlchunk" },
  -- { import = "astrocommunity.ai.kurama622-llm-nvim" },
  { import = "astrocommunity.test.nvim-coverage" },
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.quickfix.quicker-nvim" },
  { import = "astrocommunity.game.leetcode-nvim" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.completion.blink-cmp-tmux" },
  -- { import = "astrocommunity.completion.avante-nvim" },
  { import = "astrocommunity.search.nvim-spectre" }, -- 文本替换插件
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.spring-boot" },
  { import = "astrocommunity.pack.full-dadbod" }, -- 数据库链接查询插件
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.cpp" },
  -- { import = "astrocommunity.pack.cs-omnisharp" },
  { import = "astrocommunity.markdown-and-latex.markmap-nvim" }, -- 思维导图
  { import = "astrocommunity.markdown-and-latex.vimtex" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  -- { import = "astrocommunity.markdown-and-latex.markview-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.motion.hop-nvim" }, -- 快速跳转插件， 为s；<S-s>
  { import = "astrocommunity.editing-support.auto-save-nvim" },
  { import = "astrocommunity.editing-support.multicursors-nvim" }, -- 用得少
  { import = "astrocommunity.editing-support.undotree" },
  { import = "astrocommunity.editing-support.copilotchat-nvim" },
  { import = "astrocommunity.editing-support.yanky-nvim" },

  -- { import = "astrocommunity.editing-support.chatgpt-nvim" },
  -- { import = "astrocommunity.remote-development.remote-sshfs-nvim" }, --远程开发，但是卡
  -- { import = "astrocommunity.remote-development.distant-nvim" }, --远程开放，难配置
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" }, -- 调试时变量值在附近
  { import = "astrocommunity.debugging.persistent-breakpoints-nvim" }, -- persistent breakpoints
  { import = "astrocommunity.color.twilight-nvim" }, -- 高亮当前编辑
  -- { import = "astrocommunity.color.transparent-nvim" }, -- 透明化窗口
  { import = "astrocommunity.terminal-integration.vim-tpipeline" }, -- Embed your vim status in tmux
  -- { import = "astrocommunity.icon.mini-icons" },
  { import = "astrocommunity.split-and-window.colorful-winsep-nvim" }, -- 提示活跃窗口
  { import = "astrocommunity.programming-language-support.rest-nvim" }, -- 发送http请求插件
  -- { import = "astrocommunity.media.image-nvim" },
  -- import/override with your plugins folder
}
