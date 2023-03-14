require('telescope').setup {
  extensions = {
    project = {
      base_dirs = {
        '~/prog',
        '~/Notes',
      },
      hidden_files = true,
      theme = "dropdown",
      order_by = "asc",
      search_by = "recent",
    }
  }
}

local builtin = require('telescope.builtin')

-- Note:
-- It is possible to access these lists through the command line, like this:
-- :lua require('telescope.builtin').vim_options()
-- :lua require('telescope.builtin').git_commits()
-- :lua require('telescope.builtin').git_branches()

vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
vim.keymap.set('n', '<leader>*', builtin.grep_string, {})
vim.keymap.set('n', '<leader>bb', builtin.buffers, {desc='list buffers'})
vim.keymap.set('n', '<leader>ts', builtin.live_grep, {desc='live grep'})
vim.keymap.set('n', '<leader>tt', builtin.help_tags, {desc='help_tags'})
vim.keymap.set('n', '<leader>tc', builtin.commands, {desc='commands'})
vim.keymap.set('n', '<leader>th', builtin.command_history, {desc='command_history'})
vim.keymap.set('n', '<leader>tm', builtin.man_pages, {desc='man_pages'})

vim.keymap.set('n', '<leader>gf', builtin.git_files, {desc='search git files'})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {desc='git branches'})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {desc='git commits'})

local project = require'telescope'.load_extension('project')

vim.keymap.set('n', '<leader>pp', project.project, {})
