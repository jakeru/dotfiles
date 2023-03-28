-- Initial inspiration from:
-- https://github.com/LunarVim/Neovim-from-scratch
local function keymap(m, k, v, desc)
  -- Documentation can be found here:
  -- https://github.com/nanotee/nvim-lua-guide#defining-mappings
  -- local opts = { noremap = true, silent = true }
  local opts = { desc = desc }
  vim.keymap.set(m, k, v, opts)
end

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Save files
keymap('n', '<Leader>fs', ':w<cr>')

-- Navigate buffers
keymap("n", "<C-l>", ":bnext<cr>")
keymap("n", "<C-h>", ":bprevious<cr>")
keymap('n', '<Leader>bd', ':bdelete<cr>')

-- Source file
keymap('n', '<Leader>s', ':source<cr>')

-- Move around
keymap('n', '<S-h>', '0')

-- Execute something
keymap('n', '<Leader>e', ':')

-- Keep selection when indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Explore files
keymap('n', '<Leader>fe', ':Explore<cr>', 'Explore')

-- Neotree 
keymap('n', '<Leader>ff', ':Neotree toggle reveal<cr>', 'NeoTree')
keymap('n', '<Leader>gg', ':Neotree float git_status<cr>', 'NeoTree git status')

-- undotree
keymap('n', '<Leader>u', vim.cmd.UndotreeToggle, "Undotree")

-- fugitive
keymap('n', '<Leader>gs', vim.cmd.Git, "Git status")

