-- Use space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Setup basics 
require('core.lazy')
require('core.keymaps')
require('core.options')
require('core.extra')
require('core.neovide')

-- Configure plugins
require('conf.autopairs')
require('conf.cmp')
require('conf.snippets')
require('conf.colorscheme')
require('conf.comment')
require('conf.harpoon')
require('conf.hop')
require('conf.lsp')
require('conf.lualine')
require('conf.gitsigns')
require('conf.neo-tree')
require('conf.project')
require('conf.telescope')
require('conf.treesitter')
require('conf.surround')
require('conf.yanky')
