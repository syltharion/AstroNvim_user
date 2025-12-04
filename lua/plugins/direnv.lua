return {
  "NotAShelf/direnv.nvim",
  opts = function(_, opts)
    -- Path to the direnv executable
    opts.bin = "direnv"

    -- Whether to automatically load direnv when entering a directory with .envrc
    opts.autoload_direnv = true

    -- Statusline integration
    opts.statusline = {
      -- Enable statusline component
      enabled = true,
      -- Icon to display in statusline
      icon = "󱚟",
    }

    opts.keybindings = nil
    -- Keyboard mappings
    -- opts.keybindings = {
    --   allow = "<Leader>da",
    --   deny = "<Leader>dd",
    --   reload = "<Leader>dr",
    --   edit = "<Leader>de",
    -- }

    -- Notification settings
    opts.notifications = {
      -- Log level (vim.log.levels.INFO, ERROR, etc.)
      level = vim.log.levels.INFO,
      -- Don't show notifications during autoload
      silent_autoload = true,
    }
  end,
  -- config = function() require("direnv").setup {} end,
}
