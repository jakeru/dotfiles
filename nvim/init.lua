-- Use space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Require some things
require('core.lazy')
require('core.options')
require('core.keymaps')

-- Set colorscheme
vim.api.nvim_command("colorscheme tokyonight")
