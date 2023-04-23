-- Inspiration from:
-- https://github.com/gbprod/yanky.nvim

local status_ok, yanky = pcall(require, 'yanky')
if not status_ok then
    return
end

local mapping = require("yanky.telescope.mapping")

yanky.setup({
    ring = {
        history_length = 1000,
        storage = 'shada',
        sync_with_numbered_registers = true,
        cancel_event = 'update',
    },
    system_clipboard = {
        sync_with_ring = true,
    },
    highlight = {
        on_put = true,
        on_yank = true,
        timer = 250,
    },
    preserve_cursor_position = {
        enabled = true,
    },
    picker = {
        telescope = {
            mappings = {
                default = mapping.put("p"),
                n = {
                    p = mapping.put("p"),
                    d = mapping.delete(),
                },
            }
        }
    }
})

require('telescope').load_extension('yank_history')

local jlib = require('jlib')

vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleBackward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleForward)")

vim.keymap.set({ "x" }, "y", "<Plug>(YankyYank)")

jlib.nmap('<Leader>ty',
    require("telescope").extensions.yank_history.yank_history,
    'Yank history')
