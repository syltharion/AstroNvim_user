local overseer = require "overseer"

return {
  "stevearc/overseer.nvim",
  -- event = "VeryLazy",
  lazy = true,
  opts = function(_, opts)
    overseer.add_template_hook({
      module = "vscode", -- 匹配所有的 vscode 模板
      -- name = "demo", -- 任务名
    }, function(task_defn, util)
      -- 如果该项目是 CMake 项目，则先Build
      if require("cmake-tools").is_cmake_project() then
        vim.cmd "CMakeBuild"
        -- util.add_component(task_defn, { "on_output_quickfix", open = true })
      end
    end)

    opts.component_aliases = {
      -- Most tasks are initialized with the default components
      default = {
        { "display_duration", detail_level = 2 },
        "on_output_summarize",
        "on_output_quickfix", -- This component is only added if the task has a quickfix list
        "on_exit_set_status",
        "on_complete_notify",
        { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
      },
      -- Tasks from tasks.json use these components
      default_vscode = {
        "default",
        "on_result_diagnostics",
      },
    }
    opts.strategy = {
      "toggleterm",
      -- load your default shell before starting the task
      use_shell = false,
      -- overwrite the default toggleterm "direction" parameter
      -- direction = "right",
      -- overwrite the default toggleterm "highlights" parameter
      highlights = nil,
      -- overwrite the default toggleterm "auto_scroll" parameter
      auto_scroll = true,
      -- have the toggleterm window close and delete the terminal buffer
      -- automatically after the task exits
      close_on_exit = true,
      -- have the toggleterm window close without deleting the terminal buffer
      -- automatically after the task exits
      -- can be "never, "success", or "always". "success" will close the window
      -- only if the exit code is 0.
      quit_on_exit = "always", --总是退出,否则会干扰调试的文件识别
      -- open the toggleterm window when a task starts
      open_on_start = true,
      -- mirrors the toggleterm "hidden" parameter, and keeps the task from
      -- being rendered in the toggleable window
      hidden = false,
      -- command to run when the terminal is created. Combine with `use_shell`
      -- to run a terminal command before starting the task
      on_create = nil,
    }
    return opts
  end,
}
