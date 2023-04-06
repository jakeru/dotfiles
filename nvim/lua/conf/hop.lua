-- Neovim motions on speed!
-- https://github.com/phaazon/hop.nvim

local status_ok, hop = pcall(require, 'hop')
if not status_ok then
    return
end

hop.setup({})

local jlib = require('jlib')
local directions = require('hop.hint').HintDirection

jlib.nmap('s', function()
  hop.hint_char2({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, 'Hop 2 char same line')

jlib.nmap('<leader>j', function()
  hop.hint_char2()
end, 'Hop 2 char')

jlib.nmap('<leader>w', function()
  hop.hint_words()
end, 'Hop word')

jlib.nmap('<leader>l', function()
  hop.hint_lines_skip_whitespace()
end, 'Hop line')

