-- Neovim motions on speed!
-- https://github.com/phaazon/hop.nvim

local status_ok, hop = pcall(require, 'hop')
if not status_ok then
    return
end

hop.setup({})

local jlib = require('jlib')
local directions = require('hop.hint').HintDirection

local modes = {'n', 'v', 'x'}

-- Jump forward on the current line.
jlib.map(modes, 's', function()
  hop.hint_char2({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, 'Hop 2 char same line')

-- Jump to anywhere on the screen.
jlib.map(modes, '<leader>j', function()
  hop.hint_char2()
end, 'Hop 2 char')

-- Jump to a word on the screen.
jlib.map(modes, '<leader>w', function()
  hop.hint_words()
end, 'Hop word')

-- Jump to line on the screen.
jlib.map(modes, '<leader>l', function()
  hop.hint_lines_skip_whitespace()
end, 'Hop line')

