return {
  "askfiy/nvim-picgo",
  opts = function(_, opts)
    -- method to informe
    -- 1. notify
    -- 2. echo
    opts.notice = "notify"
    -- Whether the generated markdown link saves the upload name of the image
    -- boolean
    opts.image_name = false
    -- debug mode
    opts.debug = false
    return opts
  end,
}
