-- override blink.cmp plugin
return {
  "Saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    "fang2hou/blink-copilot",
  },
  opts = function(_, opts)
    if not opts.keymap then opts.keymap = {} end
    opts.keymap["<Tab>"] = {
      "snippet_forward",
      function()
        if vim.g.ai_accept then return vim.g.ai_accept() end
      end,
      "fallback",
    }
    opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }
    opts.sources = {
      default = function()
        local success, node = pcall(vim.treesitter.get_node)
        if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
          return { "buffer" }
        else
          return { "copilot", "lsp", "snippets", "path", "buffer" }
        end
      end,
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          async = true,
          score_offset = 100,
        },
        path = { score_offset = 3 },
        lsp = { score_offset = 0 },
        snippets = { score_offset = -1 },
        buffer = { score_offset = -3 },
        -- solve dap-repl reporting issue
        dap = {
          name = "dap",
          module = "blink.compat.source",
          enabled = function() require("cmp_dap").is_dap_buffer() end,
        },
      },
    }
  end,
}
