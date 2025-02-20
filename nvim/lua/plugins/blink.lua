return {
    'saghen/blink.cmp',
    dependencies = {
        { 'rafamadriz/friendly-snippets' },
        { 'L3MON4D3/LuaSnip', version = 'v2.*' }
    },

    -- use a release tag to download pre-built binaries
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'none',
            ['<C-d>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<C-y>'] = { 'select_and_accept', 'fallback' },
            -- ['<Enter>'] = { 'select_and_accept', 'fallback' },

            ['<C-k>'] = { 'select_prev', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback' },

            ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-m>'] = { 'scroll_documentation_down', 'fallback' },

            ['<C-l>'] = { 'snippet_forward' },
            ['<C-h>'] = { 'snippet_backward', 'fallback' },

            ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        snippets = { preset = "luasnip" },
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            min_keyword_length = 2,
        },
        completion = {
            list = {
                selection = {
                    -- Setting `preselect` to `false` disables auto selecting first item. Useful if using Enter as 'select_and_accept'.
                    --preselect = false,
                }
            }
        }
    },
}
