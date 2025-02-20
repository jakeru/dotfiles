local jlib = require('jlib')

-- Save files
jlib.nmap('<Leader>fs', ':w<Cr>')

-- Navigate buffers
jlib.nmap('<Leader>bd', ':Bdelete<Cr>', 'Delete buffer')

-- Navigate windows
jlib.nmap('<C-w>d', ':close<Cr>', 'Close window')

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

-- undotree
jlib.nmap('<Leader>u', vim.cmd.UndotreeToggle, "Undotree")

-- fugitive
jlib.nmap('<Leader>gs', vim.cmd.Git, "Git status")

