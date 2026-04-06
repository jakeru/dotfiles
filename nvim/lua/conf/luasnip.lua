require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_lua').lazy_load({
    paths = {
        vim.fn.stdpath("config") .. "/lua/snippets",
    }
})
require("luasnip").config.set_config({
  enable_autosnippets = true,
})
