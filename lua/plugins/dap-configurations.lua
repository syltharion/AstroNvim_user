local current_filename = vim.fn.fnamemodify(vim.fn.expand "%:p", ":t:r")

local dap = require "dap"
return {
  -- event = "VeryLazy",
  lazy = true,
  "jay-babu/mason-nvim-dap.nvim",
  opts = function(_, opts)
    opts.handlers = {
      codelldb = function(source_name)
        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
          },
        }
        if vim.fn.has "win32" == 1 then dap.adapters.codelldb.options = {
          detached = false,
        } end
      end,
      cppdbg = function(source_name)
        dap.adapters.cppdbg = {
          id = "cppdbg",
          type = "executable",
          command = vim.fn.exepath "OpenDebugAD7",
        }
        if vim.fn.has "win32" == 1 then dap.adapters.cppdbg.options = {
          detached = false,
        } end
      end,
    }
    -- dap.adapters.gdb = {
    --   type = "executable",
    --   command = "gdb",
    --   args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    -- }
    dap.configurations.cpp = {
      -- {
      --   name = "C++ Debug (GDB)",
      --   type = "cppdbg",
      --   request = "launch",
      --   program = "${workspaceFolder}/build/target/${fileBasenameNoExtension}",
      --   cwd = "${workspaceFolder}",
      --   stopAtEntry = false,
      --   MIMode = "gdb",
      --   setupCommands = {
      --     { command = "file", args = { "${file}" }, description = "加载程序" },
      --     { command = "break", args = { "main" }, description = "在main函数打断点" },
      --     { command = "layout asm", description = "启动时切换到汇编视图" }, -- 关键指令
      --   },
      -- },
      -- {
      --   name = "Launch file",
      --   type = "codelldb",
      --   request = "launch",
      --   program = "/tmp/cppBin/" .. current_filename .. ".out",
      --   console = "integratedTerminal",
      --   cwd = "${workspaceFolder}",
      --   args = {},
      --   stopAtEntry = false,
      -- },
      -- {
      --   name = "Launch file (args)",
      --   type = "codelldb",
      --   request = "launch",
      --   program = "/tmp/cppBin/" .. current_filename .. ".out",
      --   console = "integratedTerminal",
      --   cwd = "${workspaceFolder}",
      --   args = function() return vim.split(vim.fn.input "Args: ", " +", { trimempty = true }) end,
      --   stopAtEntry = false,
      -- },
      -- {
      --   name = "Attach to gdbserver :1234 (x86)",
      --   type = "cppdbg",
      --   request = "launch",
      --   MIMode = "gdb",
      --   miDebuggerServerAddress = "localhost:1234",
      --   miDebuggerPath = vim.fn.exepath "x86_64-elf-gdb",
      --   cwd = "${workspaceFolder}",
      --   program = "${workspaceFolder}/build/Debug/source/boot/boot.elf",
      --   -- program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
      --   setupCommands = {
      --     {
      --       description = "为 gdb 启用整齐打印",
      --       text = "-enable-pretty-printing",
      --       ignoreFailures = true,
      --     },
      --     {
      --       description = "将反汇编风格设置为 Intel",
      --       text = "-gdb-set disassembly-flavor intel",
      --       ignoreFailures = true,
      --     },
      --     --设置体系结构: i8086，方便以16位方式进行反汇编
      --     -- {
      --     --     "description= "设置体系结构",
      --     --     "text= "-gdb-set arch i8086",
      --     --     "ignoreFailures= true
      --     -- }
      --   },
      -- gdb连接后的设置
      -- postRemoteConnectCommands = {
      --   {
      --     description = "加载boot符号文件",
      --     text = "-file-symbol-file ./build/Debug/source/boot/boot.elf",
      --     ignoreFailures = false,
      --   },
      --   {
      --     description = "加载内核符号文件",
      --     text = "add-symbol-file ./build/Debug/source/kernel/kernel.elf 0x100000",
      --     ignoreFailures = false,
      --   },
      --   {
      --     description = "加载load符号文件",
      --     text = "add-symbol-file ./build/Debug/source/loader/loader.elf 0x8000",
      --     ignoreFailures = false,
      --   },
      --   -- {
      --   --     description= "加载boot符号文件",
      --   --     text= "add-symbol-file ./build/Debug/source/boot/boot.elf 0x7c00",
      --   --     ignoreFailures= false
      --   -- },
      --   -- {
      --   --     description= "加载init符号文件",
      --   --     -- 为了方便调试，不同应用的起始地址应当不同，这样才能正确单步调度和设置断点
      --   --     text= "add-symbol-file ./build/Debug/source/init/init.elf 0x82000000",
      --   --     ignoreFailures= false
      --   -- },
      --   -- {
      --   --     description= "加载shell符号文件",
      --   --     -- 为了方便调试，不同应用的起始地址应当不同，这样才能正确单步调度和设置断点
      --   --     text= "add-symbol-file ./build/Debug/source/shell/shell.elf 0x81000000",
      --   --     ignoreFailures= false
      --   -- },
      --   -- {
      --   --     description= "加载loop符号文件",
      --   --     -- 为了方便调试，不同应用的起始地址应当不同，这样才能正确单步调度和设置断点
      --   --     text= "add-symbol-file ./build/Debug/source/loop/loop.elf 0x83000000",
      --   --     ignoreFailures= false
      --   -- },
      --   {
      --     description = "运行至0x7c00",
      --     text = "-exec-until *0x7c00",
      --     ignoreFailures = false,
      --   },
      -- },
      -- preLaunchTask = "1调试准备", -- 仅在windows下可自动运行
      -- },
      -- {
      --   name = "Attach to gdbserver (port)",
      --   type = "cppdbg",
      --   request = "launch",
      --   MIMode = "gdb",
      --   miDebuggerServerAddress = function()
      --     local uri = vim.fn.input "[host]:port : "
      --     if uri:find "^%d+$" == 1 then
      --       uri = "localhost:" .. uri
      --     elseif uri:find(":", nil, true) == 1 then
      --       uri = "localhost" .. uri
      --     end
      --     return uri
      --   end,
      --   miDebuggerPath = vim.fn.exepath "lldb",
      --   cwd = "${workspaceFolder}",
      --   args = function() return vim.split(vim.fn.input "Args: ", " +", { trimempty = true }) end,
      --   program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
      -- },
    }
  end,
}
