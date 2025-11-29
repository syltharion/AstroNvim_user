return {
  "kawre/leetcode.nvim",
  -- enabled = vim.fn.has "linux" == 1, -- Linux only
  -- event = "VeryLazy",
  lazy = true,
  dependencies = {
    { "williamboman/mason.nvim", optional = true },
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>L"] = { desc = "Leetcode" },
            ["<Leader>Le"] = { "<cmd>Leet pick<CR>", desc = "Leet pick" },
            ["<Leader>La"] = { "<cmd>Leet list<CR>", desc = "Leet list" },
            ["<Leader>Ld"] = { "<cmd>Leet desc<CR>", desc = "Leet description" },
            ["<Leader>Lt"] = { "<cmd>Leet test<CR>", desc = "Leet test" },
            ["<Leader>Ls"] = { "<cmd>Leet submit<CR>", desc = "Leet submit" },
            ["<Leader>Lc"] = { "<cmd>Leet console<CR>", desc = "Leet console" },
            ["<Leader>Lf"] = { "<cmd>Leet filter<CR>", desc = "Leet filter" },
            ["<Leader>LR"] = { "<cmd>Leet reset<CR>", desc = "Leet reset" },
            ["<Leader>LU"] = { "<cmd>Leet use_testcase<CR>", desc = "Leet use testcase" },
            ["<Leader>LRF"] = { "<cmd>Leet reset_filter<CR>", desc = "Leet reset filter" },
          },
        },
      },
    },
  },
  opts = function(_, opts)
    opts.arg = "lc"
    opts.lang = "cpp"
    opts.cn = { -- leetcode.cn
      enabled = true, ---@type boolean
      translator = true, ---@type boolean
      translate_problems = true, ---@type boolean
    }
    opts.storage = {
      -- 家目录
      home = vim.fn.expand "$HOME" .. "/Algorithm/Leetcode",
      cache = vim.fn.expand "$HOME" .. "/Algorithm/Leetcode/cache",
    }

    opts.logging = true

    opts.injector = {
      ["cpp"] = {
        before = {
          '#include "bits/stdc++.h"',
          "using namespace std;",
          -- "/* @lc app=leetcode id=  lang=cpp */",
        },
        after = "",
      },
    }
    opts.cache = {
      update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
    }

    -- console = {
    -- 	open_on_runcode = true, ---@type boolean

    -- 	dir = "nrow", ---@type lc.direction

    -- 	size = { ---@type lc.size
    -- 		width = "90%",
    -- 		height = "75%",
    -- 	},

    -- 	result = {
    -- 		size = "60%", ---@type lc.size
    -- 	},
    -- 	testcase = {
    -- 		virt_text = true, ---@type boolean

    -- 		size = "40%", ---@type lc.size
    -- 	},
    -- },

    opts.description = {
      position = "right",
      width = "50%",
      show_stats = true,
    }

    -- hooks = {
    -- 	---@type fun()[]
    -- 	LeetEnter = {},

    -- 	---@type fun(question: lc.ui.Question)[]
    -- 	LeetQuestionNew = {},
    -- },

    opts.keys = {
      toggle = { "q", "<Esc>" }, ---@type string|string[]
      confirm = { "<CR>" }, ---@type string|string[]

      reset_testcases = "r", ---@type string
      use_testcase = "U", ---@type string
      focus_testcases = "H", ---@type string
      focus_result = "L", ---@type string
    }

    ---@type boolean
    opts.image_support = true
    return opts
  end,
}
