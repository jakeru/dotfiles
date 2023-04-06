require('telescope').setup {
    extensions = {
    --     project = {
    --         base_dirs = {
    --             '~/prog',
    --             '~/Notes',
    --         },
    --         hidden_files = true,
    --         theme = "dropdown",
    --         order_by = "asc",
    --         search_by = "recent",
    --     },
        fzf = {
            fuzzy = true,
        }
    }
}

-- Enable telescope fzf native
-- Note that this should be done after the call to setup
-- according to:
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
require('telescope').load_extension('fzf')

local function nmap(k, v, desc)
    vim.keymap.set('n', k, v, { desc = desc })
end

local builtin = require('telescope.builtin')

-- Note:
-- It is possible to access these lists through the command line, like this:
-- :lua require('telescope.builtin').vim_options()
-- :lua require('telescope.builtin').git_commits()
-- :lua require('telescope.builtin').git_branches()
--
-- Or even easier:
-- :Telescope git_bcommits

nmap('<leader><leader>', builtin.find_files, 'Telescope find files')
nmap('<leader>*', builtin.grep_string, 'Telescope grep')
nmap('<leader>bb', builtin.buffers, 'list buffers')
nmap('<leader>ts', builtin.live_grep, 'live grep')
nmap('<leader>tt', builtin.help_tags, 'help_tags')
nmap('<leader>tc', builtin.commands, 'commands')
nmap('<leader>th', builtin.command_history, 'command_history')

local function all_man_pages()
    builtin.man_pages({ sections = { 'ALL' } })
end

nmap('<leader>tm', all_man_pages, 'man_pages')

nmap('<leader>gf', builtin.git_files, 'search git files')
nmap('<leader>gb', builtin.git_branches, 'git branches')
nmap('<leader>gc', builtin.git_commits, 'git commits')

-- local project = require 'telescope'.load_extension('project')

-- nmap('<leader>pp', project.project, 'Projects')

-- Fuzzy finding, from the kickstarter plugin.
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = true,
    })
end, { desc = '[/] Fuzzily search in current buffer' })
