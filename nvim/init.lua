-- Use space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Setup basics 
require('core.lazy')
require('core.options')
require('core.keymaps')

-- Configure plugins
require('conf.cmp')
require('conf.colorscheme')
require('conf.harpoon')
require('conf.lsp')
require('conf.neo-tree')
require('conf.telescope')
require('conf.treesitter')
