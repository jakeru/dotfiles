-- Use space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Setup basics 
require('core.lazy')
require('core.options')
require('core.keymaps')
require('core.neovide')

-- Configure plugins
require('conf.autopairs')
require('conf.cmp')
require('conf.colorscheme')
require('conf.harpoon')
require('conf.hop')
require('conf.lsp')
require('conf.lualine')
require('conf.neo-tree')
require('conf.project')
require('conf.telescope')
require('conf.treesitter')
require('conf.yanky')
