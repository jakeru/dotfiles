-- Neovim motions on speed!
-- https://github.com/phaazon/hop.nvim

local status_ok, hop = pcall(require, 'hop')
if not status_ok then
    return
end

hop.setup({})

local jlib = require('jlib')

local modes = { 'n', 'v', 'x' }

-- Note that this module has support for many more things but I have
-- disabled them.
-- Examples: hint_words, hint_lines_skip_whitespace

-- Jump to anywhere on the screen.
jlib.map(modes, '<leader>j', function()
    hop.hint_char2()
end, 'Hop 2 char')
