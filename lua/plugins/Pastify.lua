---@diagnostic disable: missing-fields
return {
  "TobinPalmer/pastify.nvim", --markdown image pasting
  enable = false,
  lazy = true,
  -- event = "VeryLazy",
  -- enabled = vim.fn.has "mac" == 1, -- macOS only
  cmd = { "Pastify" },
  keys = vim.api.nvim_set_keymap(
    "n",
    "<leader>MP",
    "<Cmd>Pastify<CR>",
    { noremap = true, silent = true, desc = "tool: Past Image to Markdown" }
  ),
  config = function()
    require("pastify").setup {
      opts = {
        absolute_path = false, -- use absolute or relative path to the working directory
        apikey = "ea670f07ed9345145c483ccffe463b1c", -- Needed if you want to save online.
        local_path = "/attachments/imgs/", -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
        save = "local", -- Either 'local' or 'online'
      },
      ft = { -- Custom snippets for different filetypes, will replace $IMG$ with the image url
        html = '<img src="$IMG$" alt="">',
        markdown = "![]($IMG$)",
        -- markdown = '<img  height=300 src="$IMG$" alt="">',
        tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
      },
    }
  end,
}
