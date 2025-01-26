local cmp = require "cmp"

local luasnip = require "luasnip"

-- local lspkind = require "lspkind"
-- lspkind.init {}

local mapping = {
    ["<C-j>"] = cmp.mapping(
        cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }, { "i", "c" }
    ),
    ["<C-k>"] = cmp.mapping(
        cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }, { "i", "c" }
    ),
    ["<C-l>"] = cmp.mapping(
        cmp.mapping.confirm {
            behavior = cmp.SelectBehavior.Insert,
            select = true,
        },
        { "i", "c" }
    ),
}

cmp.setup {
    sources = {
        { name = "nvim_lsp", keyword_length = 2 },
        { name = "luasnip",  keyword_length = 2 },
        { name = "buffer",   keyword_length = 3 },
        { name = "path" },
    },
    mapping = mapping,
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = mapping,
    sources = {
        { name = 'buffer', keyword_length = 2 },
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = mapping,
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

require('luasnip.loaders.from_vscode').lazy_load()

vim.keymap.set({ "i", "s" }, "<C-;>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true, desc = "luasnip.expand_or_jump" })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true, desc = "luasnip.jump(-1)" })
