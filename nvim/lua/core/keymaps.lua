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

-- Explore files
keymap('n', '<Leader>ff', ':Explore<CR>')

-- Save files quickly
keymap('n', '<Leader>fs', ':w<CR>')

-- Navigate buffers
keymap("n", "<C-l>", ":bnext<CR>")
keymap("n", "<C-h>", ":bprevious<CR>")
keymap('n', '<Leader>bd', ':bdelete<CR>')

-- Source file
keymap('n', '<Leader>s', ':source<CR>')

-- Move around
keymap('n', '<S-h>', '0')

-- Execute something
-- Note: Nothing is shown before the user types something.
keymap('n', '<Leader>e', ':')

-- undotree
keymap('n', '<Leader>u', vim.cmd.UndotreeToggle, "Undotree")

-- fugitive
keymap('n', '<Leader>gs', vim.cmd.Git, "Git status")

