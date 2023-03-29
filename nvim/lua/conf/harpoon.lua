-- Configure harpoon
-- from:
-- https://github.com/ThePrimeagen/harpoon

local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

local function nmap(k, v, desc)
  vim.keymap.set('n', k, v, {desc=desc})
end

-- The quick menu shows a menu
-- The text can be edited, so `dd` can for example be used
-- to delete a line.
nmap('<leader>hq', ui.toggle_quick_menu, 'Harpoon menu')

nmap('<leader>ha', mark.add_file, 'Harpoon add file')

nmap('<leader>hh', ui.nav_prev, 'Harpoon prev')
nmap('<leader>hl', ui.nav_next, 'Harpoon next')

nmap('<leader>1', function() ui.nav_file(1) end, 'Harpoon 1')
nmap('<leader>2', function() ui.nav_file(2) end, 'Harpoon 2')
nmap('<leader>3', function() ui.nav_file(3) end, 'Harpoon 3')

require('telescope').load_extension('harpoon')
nmap('<leader>ht', ':Telescope harpoon marks<cr>', 'Telescope Harpoon')

