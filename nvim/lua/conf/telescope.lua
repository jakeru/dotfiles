local telescope = require('telescope')

local actions = require "telescope.actions"

local fb_actions = telescope.extensions.file_browser.actions

telescope.setup {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
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

local function list_buffers()
    builtin.buffers({ ignore_current_buffer = true, sort_mru = true })
end

jlib.nmap('<leader><leader>', builtin.find_files, 'Telescope find files')

jlib.nmap('<leader>bb', list_buffers, 'List buffers')

jlib.nmap('<leader>*', builtin.grep_string, 'Telescope grep')

local multigrep = function()
    require("conf.telescope_multigrep").multigrep({})
end

jlib.nmap('<leader>tg', multigrep, "Live Multi grep")

jlib.nmap('<leader>tk', builtin.keymaps, 'command_history')
jlib.nmap('<leader>tt', builtin.help_tags, 'help_tags')
jlib.nmap('<leader>tc', builtin.commands, 'commands')
jlib.nmap('<leader>th', builtin.command_history, 'command_history')

jlib.nmap('<leader>tls', builtin.treesitter, 'Symbols')
jlib.nmap('<leader>tlr', builtin.lsp_references, 'lsp_references')
jlib.nmap('<leader>tli', builtin.lsp_incoming_calls, 'lsp_incoming_calls')
jlib.nmap('<leader>tlo', builtin.lsp_outgoing_calls, 'lsp_outgoing_calls')
jlib.nmap('<leader>tls', builtin.lsp_document_symbols, 'lsp_document_symbols')

local function document_symbols_funcions()
    builtin.lsp_document_symbols({ symbols = { "Function" } })
end

jlib.nmap('<leader>tlf', document_symbols_funcions, 'List functions in buffer')

local function diagnostics_in_current_buffer()
    builtin.diagnostics({bufnr=0})
end

jlib.nmap('<leader>tld', diagnostics_in_current_buffer, 'Diagnostics in buffer')
jlib.nmap('<leader>tlD', builtin.diagnostics, 'Diagnostics in workspace')

local function all_man_pages()
    builtin.man_pages({ sections = { 'ALL' } })
end

jlib.nmap('<leader>tm', all_man_pages, 'man_pages')

jlib.nmap('<leader>gf', builtin.git_files, 'search git files')
jlib.nmap('<leader>gb', builtin.git_branches, 'git branches')
jlib.nmap('<leader>gc', builtin.git_commits, 'git commits')

jlib.nmap('<leader>tf', ':Telescope file_browser<Cr>', 'File browser')

-- Fuzzy finding, from the kickstarter plugin.
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0,
        previewer = true,
    })
end, { desc = '[/] Fuzzily search in current buffer' })
