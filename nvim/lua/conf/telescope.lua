local telescope = require('telescope')

local actions = require "telescope.actions"

local fb_actions = telescope.extensions.file_browser.actions

telescope.setup {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },
            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                ["?"] = actions.which_key,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
        },
        file_browser = {
            hijack_netrw = false,
            mappings = {
                ["i"] = {
                    ['<Left>'] = fb_actions.goto_parent_dir,
                },
                ["n"] = {
                },
            },
        }
    }
}

-- Enable telescope fzf native
-- Note that this should be done after the call to setup
-- according to:
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
require('telescope').load_extension('fzf')

--File browser plugin
require("telescope").load_extension("file_browser")

telescope.load_extension('media_files')

local jlib = require('jlib')

local builtin = require('telescope.builtin')

-- Note:
-- It is possible to access these lists through the command line, like this:
-- :lua require('telescope.builtin').vim_options()
-- :lua require('telescope.builtin').git_commits()
-- :lua require('telescope.builtin').git_branches()
--
-- Or even easier:
-- :Telescope git_bcommits

jlib.nmap('<leader><leader>', builtin.find_files, 'Telescope find files')
jlib.nmap('<leader>*', builtin.grep_string, 'Telescope grep')
jlib.nmap('<leader>bb', builtin.buffers, 'list buffers')
jlib.nmap('<leader>ts', builtin.live_grep, 'live grep')
jlib.nmap('<leader>tt', builtin.help_tags, 'help_tags')
jlib.nmap('<leader>tc', builtin.commands, 'commands')
jlib.nmap('<leader>th', builtin.command_history, 'command_history')

local function all_man_pages()
    builtin.man_pages({ sections = { 'ALL' } })
end

jlib.nmap('<leader>tm', all_man_pages, 'man_pages')

jlib.nmap('<leader>gf', builtin.git_files, 'search git files')
jlib.nmap('<leader>gb', builtin.git_branches, 'git branches')
jlib.nmap('<leader>gc', builtin.git_commits, 'git commits')

jlib.nmap('<leader>fo', ':Telescope file_browser<Cr>', 'File browser')

-- Fuzzy finding, from the kickstarter plugin.
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = true,
    })
end, { desc = '[/] Fuzzily search in current buffer' })
