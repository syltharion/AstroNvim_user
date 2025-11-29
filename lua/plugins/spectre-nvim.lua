return {
  "nvim-pack/nvim-spectre",
  -- event = "VeryLazy",
  lazy = true,
  opts = function(_, opts)
    -- macos下会生成备份-E的文件
    if vim.fn.has "mac" == 1 then
      opts.replace_engine = {
        ["sed"] = {
          cmd = "sed",
          args = {
            "-i",
            "",
            "-E",
          },
        },
      } --修改的地方
    end
    opts.mapping = {
      send_to_qf = { map = "Q" },
      replace_cmd = { map = "C" },
      show_option_menu = { map = "o" },
      run_current_replace = { map = "c" },
      run_replace = { map = "R" },
      change_view_mode = { map = "v" },
      resume_last_search = { map = "L" },
       close_ = {
            map = "q",
            cmd = "<cmd>lua require('spectre').close()<CR>",
            desc = "close Spectre",
        },
    }

    return opts
  end,
}
