return {
  enabled = false,
  "nosduco/remote-sshfs.nvim",
  opts = function(_, opts)
    opts.connections = {
      ssh_configs = { -- which ssh configs to parse for hosts list
        vim.fn.expand "$HOME" .. "/.ssh/config",
        -- "/etc/ssh/ssh_config",
        -- "/path/to/custom/ssh_config"
      },
      -- NOTE: Can define ssh_configs similarly to include all configs in a folder
      -- ssh_configs = vim.split(vim.fn.globpath(vim.fn.expand "$HOME" .. "/.ssh/configs", "*"), "\n")
      sshfs_args = { -- arguments to pass to the sshfs command
        "-o reconnect",
        "-o ConnectTimeout=5",
        --        "-o cache=auto",
        "-o cache_max_size=50000",
        "-o cache_timeout=60",
        "-o compression=yes",
        "-o cache=yes",
        -- "-o large_read",
        "-o async_read",
        "-o direct_io",
        "-o no_readahead",
      },
    }
    opts.mounts = {
      -- base_dir = vim.fn.expand "$HOME" .. "/.sshfs/", -- base directory for mount points
      base_dir = vim.fn.expand "$HOME" .. "/Public/", -- base directory for mount points
      unmount_on_exit = true, -- run sshfs as foreground, will unmount on vim exit
    }
    opts.handlers = {
      on_connect = {
        change_dir = true, -- when connected change vim working directory to mount point
      },
      on_disconnect = {
        clean_mount_folders = false, -- remove mount point folder on disconnect/unmount
      },
      on_edit = {}, -- not yet implemented
    }
    opts.ui = {
      select_prompts = false, -- not yet implemented
      confirm = {
        connect = false, -- prompt y/n when host is selected to connect to
        change_dir = false, -- prompt y/n to change working directory on connection (only applicable if handlers.on_connect.change_dir is enabled)
      },
    }
    opts.log = {
      enable = false, -- enable logging
      truncate = false, -- truncate logs
      types = { -- enabled log types
        all = false,
        util = false,
        handler = false,
        sshfs = false,
      },
    }
    return opts
  end,
}
