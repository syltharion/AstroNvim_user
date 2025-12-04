-- Sort function for files
local sortFunc = function(a, b)
  -- keys of a and b
  -- not documented anywhere
  --   parent_path:           full, absolute path of parent directory
  --   type:                  "directory" (even for links), or "file"
  --   path:                  full, absolute path, no trailing slash
  --   name:                  file name
  --   is_link                bool is a symlink
  --   is_reveal_target       bool ??
  --   link_to                full, absolute path to link target
  --   loaded                 bool if file is loaded in editor
  --   id                     seems to be same as path
  --   children               type of a/b table, directories only
  --   exts                   file extension  ??, files only
  --   ext                    file extension  ??, filey only
  --   name_lcase             name, but lowercase, files only?

  if a.name == nil then
    local s = ""
    if a ~= nil and type(a) == "table" then
      for k, v in pairs(a) do
        s = s .. "[" .. k .. "] = " .. tostring(v) .. " , "
      end
    else
      s = s .. tostring(a)
    end
    print(s)
    return false
  end

  if b.name == nil then
    local s = ""
    if b ~= nil and type(b) == "table" then
      for k, v in pairs(b) do
        s = s .. "[" .. k .. "] = " .. tostring(v) .. " , "
      end
    else
      s = s .. tostring(b)
    end
    print(s)
    return true
  end

  if a.type == "directory" and b.type ~= "directory" then
    -- directories first
    return true
  end
  if b.type == "directory" and a.type ~= "directory" then
    -- directories first
    return false
  end

  if a.name:sub(1, 1) == "." and b.name:sub(1, 1) ~= "." then
    -- dotfiles last
    return false
  end
  if b.name:sub(1, 1) == "." and a.name:sub(1, 1) ~= "." then
    -- dotfiles last
    return true
  end
  -- otherwise just sort by name, case insensitive
  return a.name:upper() < b.name:upper()
end
return {
  "nvim-neo-tree/neo-tree.nvim",
  -- event = "VeryLazy",
  lazy = true,
  opts = function(_, opts)
    --默认按文件名升序排列
    opts.sort_function = sortFunc
    opts.open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" } -- when opening files, do not use windows containing these filetypes or buftypes
    -- used when sorting files and directories in the tree
    opts.sort_case_insensitive = true
    opts.filesystem.filtered_items = {
      -- hide files and directories that match these glob patterns
      visible = false,
      show_hidden_count = true,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_by_name = {
        ".git",
        ".DS_Store",
        "thumbs.db",
      },
      never_show = { ".git", ".DS_Store" },
    }
    opts.window.mappings = {
      ["<S-CR>"] = "system_open",
      ["<Space>"] = false,
      ["[b"] = "prev_source",
      ["]b"] = "next_source",
      O = "system_open",
      Y = "copy_selector",
      h = "parent_or_close",
      l = "child_or_open",
      ["\\"] = "open_vsplit",
      ["|"] = "open_split",
      s = "",
      S = "",
    }

    opts.window.auto_expand_width = false
    opts.window.width = function()
      -- 使用当前窗口宽度的 30% 来设置 Neo-tree 宽度
      return tonumber(math.floor(vim.o.columns * 0.3))
    end
    table.insert(opts.event_handlers, {
      event = "neo_tree_window_after_close",
      handler = function()
        if require("dapui.windows").layouts[1]:is_open() then require("dapui").open { reset = true } end -- 选定一个数字窗口，作为判断
      end,
    })
    -- 处理文件重命名和移动事件
    local function on_move(data) require("snacks").rename.on_rename_file(data.source, data.destination) end
    local events = require "neo-tree.events"
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })

    --opts.enable_cursor_hijack = true -- if true, the cursor will be moved to the first file in the tree when opening a file.
    opts.use_popups_for_input = false -- If false, inputs will use vim.ui.input() instead of custom floats.
    opts.open_files_do_not_replace_types = { "dapui_scopes", "terminal", "Trouble", "qf", "edgy" } -- when opening files, do not use windows containing these filetypes or buftypes

    return opts
  end,
}
