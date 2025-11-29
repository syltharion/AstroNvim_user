return {
  "Civitasv/cmake-tools.nvim",
  -- event = "VeryLazy",
  lazy = true,
  ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "alpha" },
  opts = function(_, opts)
    opts.cmake_command = "cmake" -- this is used to specify cmake command path
    opts.ctest_command = "ctest" -- this is used to specify ctest command path
    opts.cmake_use_preset = true
    opts.cmake_regenerate_on_save = true -- auto generate when save CMakeLists.txt
    opts.cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" } -- this will be passed when invoke `CMakeGenerate`
    opts.cmake_build_options = {} -- this will be passed when invoke `CMakeBuild`
    -- support macro expansion:
    --       ${kit}
    --       ${kitGenerator}
    --       ${variant:xx}
    opts.cmake_build_directory = "build/${variant:buildType}" -- 可能会被preset覆盖
    -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
    opts.cmake_soft_link_compile_commands = true -- this will automatically make a soft link from compile commands file to project root dir
    opts.cmake_compile_commands_from_lsp = false -- this will automatically set compile commands file location using lsp, to use it, please set 'cmake_soft_link_compile_commands' to false
    opts.cmake_kits_path = nil -- this is used to specify global cmake kits path, see CMakeKits for detailed usage ,default :"~/.local/share/CMakeTools/cmake-tools-kits.json"
    opts.cmake_variants_message = {
      short = { show = true }, -- whether to show short message
      long = { show = true, max_length = 40 }, -- whether to show long message
    }
    opts.cmake_dap_configuration = { -- debug settings for cmake
      name = "CmakeDebug",
      type = "codelldb",
      request = "launch",
      stopOnEntry = false,
      runInTerminal = true,
      cwd = "${workspaceFolder}",
    }

    opts.cmake_executor = { -- executor to use
      name = "overseer", -- name of the executor
      opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
      default_opts = { -- a list of default and possible values for executors
        quickfix = {
          show = "always", -- "always", "only_on_error"
          position = "belowright", -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
          size = 10,
          encoding = "utf-8", -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
          auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
        },
        toggleterm = {
          direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
          close_on_exit = false, -- whether close the terminal when exit
          auto_scroll = true, -- whether auto scroll to the bottom
          singleton = true, -- single instance, autocloses the opened one, if present
        },
        overseer = {
          new_task_opts = {
            strategy = {
              "toggleterm",
              direction = "float",
              auto_scroll = true,
              quit_on_exit = "success",
              open_on_start = false,
            },
          }, -- options to pass into the `overseer.new_task` command
          on_new_task = function(task) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
        },
      },
    }
    opts.cmake_runner = { -- runner to use
      name = "overseer", -- name of the runner
      opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
      default_opts = { -- a list of default and possible values for runners
        quickfix = {
          show = "always", -- "always", "only_on_error"
          position = "belowright", -- "bottom", "top"
          size = 10,
          encoding = "utf-8",
          auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
        },
        toggleterm = {
          direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
          close_on_exit = false, -- whether close the terminal when exit
          auto_scroll = true, -- whether auto scroll to the bottom
          singleton = true, -- single instance, autocloses the opened one, if present
        },
        overseer = {
          new_task_opts = {
            strategy = {
              "toggleterm",
              direction = "float",
              autos_croll = true,
              quit_on_exit = "success",
              open_on_start = false,
            },
          }, -- options to pass into the `overseer.new_task` command
          on_new_task = function(task) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
        },
      },
    }
    opts.cmake_notifications = {
      runner = { enabled = false },
      executor = { enabled = false },
      spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
      refresh_rate_ms = 100, -- how often to iterate icons
    }
    opts.cmake_virtual_text_support = true -- Show the target related to current file using virtual text (at right corner)
  end,
}
