local jlib = require('jlib')

-- Save files
jlib.nmap('<Leader>fs', ':w<cr>')

-- Navigate buffers
jlib.nmap('<C-l>', ':bnext<cr>', 'Next buffer')
jlib.nmap('<C-h>', ':bprevious<cr>', 'Previous buffer')
jlib.nmap('<leader>bl', ':bnext<cr>', 'Next buffer')
jlib.nmap('<leader>bh', ':bprevious<cr>', 'Previous buffer')
jlib.nmap('<Leader>bd', ':bdelete<cr>', 'Delete buffer')

-- Navigate windows
jlib.nmap('<C-w>d', ':close<cr>', 'Close window')

-- Source file
jlib.nmap('<Leader>s', ':source<cr>', 'Source')

-- Move around
jlib.nmap('<S-h>', '0')
jlib.nmap('<home>', '0')

-- Execute something
jlib.nmap('<Leader>e', ':')

-- Toggle between number formats
jlib.nmap('<Leader>n', ':NibblerToggle<Cr>')

-- Keep selection when indenting
jlib.map('v', '<', '<gv', 'Indent left')
jlib.map('v', '>', '>gv', 'Indent right')

-- Explore files
jlib.nmap('<Leader>fe', ':Explore<cr>', 'Explore')

-- Neotree
jlib.nmap('<Leader>ff', ':Neotree toggle reveal<cr>', 'NeoTree')
jlib.nmap('<Leader>gg', ':Neotree float git_status<cr>', 'NeoTree git status')

-- undotree
jlib.nmap('<Leader>u', vim.cmd.UndotreeToggle, "Undotree")

-- fugitive
jlib.nmap('<Leader>gs', vim.cmd.Git, "Git status")

