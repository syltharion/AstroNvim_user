-- some recommended exclusions. you can use `:lua print(vim.bo.filetype)` to
-- get the filetype string of the current buffer
local excluded_filetypes = {
  -- this one is especially useful if you use neovim as a commit message editor
  "gitcommit",
  -- most of these are usually set to non-modifiable, which prevents autosaving
  -- by default, but it doesn't hurt to be extra safe.
  "NvimTree",
  "Outline",
  "TelescopePrompt",
  "alpha",
  "dashboard",
  "lazygit",
  "neo-tree",
  "oil",
  "prompt",
  "toggleterm",
  "dbui",
  "http",
  "mysql",
  "dbout",
}

local excluded_filenames = {
  "do-not-autosave-me.lua",
}

local function save_condition(buf)
  if
    vim.tbl_contains(excluded_filetypes, vim.fn.getbufvar(buf, "&filetype"))
    or vim.tbl_contains(excluded_filenames, vim.fn.expand "%:t")
  then
    return false
  end
  return true
end

return {
  "okuuva/auto-save.nvim",
  lazy = true,
  -- event = "VeryLazy",
  opts = function(_, opts)
    opts.enabled = true -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
    opts.trigger_events = { -- See :h events
      immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" }, -- vim events that trigger an immediate save
      defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
      cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
    }
    -- function that takes the buffer handle and determines whether to save the current buffer or not
    -- return true: if buffer is ok to be saved
    -- return false: if it's not ok to be saved
    -- if set to `nil` then no specific condition is applied
    opts.condition = save_condition
    opts.write_all_buffers = false -- write all buffers when the current one meets `condition`
    opts.noautocmd = false -- do not execute autocmds when saving
    opts.lockmarks = false -- lock marks when saving, see `:h lockmarks` for more details
    opts.debounce_delay = 3000 -- delay after which a pending save is executed
    -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
    opts.debug = false
    return opts
  end,
}
