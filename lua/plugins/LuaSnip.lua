-- You can also easily customize additional setup of plugins that is outside of the plugin's setup call

return {
  "L3MON4D3/LuaSnip",
  event = "VeryLazy",
  config = function(plugin, opts)
    require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
    -- add more custom luasnip configuration such as filetype extend or custom snippets

    local snippet_path = vim.fn.stdpath "config" .. "/snips/"
    if not vim.tbl_contains(vim.opt.rtp:get(), snippet_path) then vim.opt.rtp:append(snippet_path) end
    local luasnip = require "luasnip"
    luasnip.filetype_extend("javascript", { "javascriptreact" })
    require("luasnip.loaders.from_lua").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_snipmate").lazy_load()
  end,
}
