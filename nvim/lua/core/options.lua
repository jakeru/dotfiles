-- Initial inspiration from:
-- https://github.com/LunarVim/Neovim-from-scratch
-- and:
-- https://github.com/nvim-lua/kickstart.nvim

-- See `:help vim.o` to get help about options.

-- Use the system clipboard.
vim.opt.clipboard = 'unnamedplus'

-- Adjust space in the neovim command line for displaying messages.
vim.opt.cmdheight = 1

-- The encoding written to a file
-- vim.opt.fileencoding = "utf-8"

-- Highlight (if true) all matches on previous search pattern
vim.opt.hlsearch = false

-- Ignore case in search patterns
vim.opt.ignorecase = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true

-- We don't need to see things like -- INSERT -- anymore
vim.opt.showmode = false

-- Highlight the current line
vim.opt.cursorline = true

-- Convert tabs to spaces
vim.opt.expandtab = true

-- The number of spaces inserted for each indentation
vim.opt.shiftwidth = 4

-- Insert spaces for a tab
vim.opt.tabstop = 4

-- Set numbered lines
vim.opt.number = true

-- set relative numbered lines
vim.opt.relativenumber = false

-- The font used in graphical neovim applications
vim.opt.guifont = "monospace:h11"

-- Persistent undo information
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})
