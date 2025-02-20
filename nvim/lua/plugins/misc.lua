return {
    {
        'folke/which-key.nvim',
        opts = {},
    },
    {
        'kylechui/nvim-surround',
    },
    -- An alternative file explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        version = "v3.x",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
    },
    -- Quickly switch between number formats hex/dec/bin
    {
        'skosulor/nibbler',
        opts = {},
    },
    {
        -- Delete a buffer using `Bdelete`.
        -- This keeps the window open, which `bdelete` does not.
        "famiu/bufdelete.nvim",
    },
    -- An alternative status bar
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },
    {
        'mbbill/undotree',
    },
    {
        'rmagatti/auto-session',
        lazy = false,
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            suppressed_dirs = { '~/', '~/Downloads', '/' },
        },
    },
    -- Git by typing Git
    -- `Git` for status
    -- `Git help` for help
    {
        'tpope/vim-fugitive',
    },
    -- Git to show signs in the margin
    -- `Gitsigns toggle_signs` to toggle
    {
        'lewis6991/gitsigns.nvim',
    },
    -- Navigation
    -- Quickly jump around in the text
    {
        'smoka7/hop.nvim',
    },
    -- Quickly jump between buffers
    {
        'ThePrimeagen/harpoon',
        dependencies = 'nvim-lua/plenary.nvim',
    },
    -- Add indentation guides even on blank lines
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        -- See `:help ibl.txt`
        config = function()
            require('ibl').setup({
                whitespace = {
                    highlight = { "Whitespace", "NonText" },
                    remove_blankline_trail = true,
                },
            })
        end
    },
    -- Add and remove comments
    {
        'numToStr/Comment.nvim',
    },
    -- Editing
    {
        'windwp/nvim-autopairs',
    },
    -- Easier word navigation
    {
        'chaoren/vim-wordmotion',
    },
    -- A yank key ring like in Emacs
    {
        'gbprod/yanky.nvim',
    },
    -- Trim trailing spaces, with user command `:Trim`
    {
        'cappyzawa/trim.nvim',
        config = function()
            require("trim").setup({
                trim_on_write = false,
            })
        end
    },
    -- Typst https://typst.app/
    {
        'kaarmu/typst.vim',
        ft = 'typst',
        lazy = false,
    },
    -- Syntax highlighting using tree-sitter
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
    },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
    },
    -- Color schemes
    {
        'folke/tokyonight.nvim',
        priority = 1000,
    },
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
    },
    {
        'nvim-telescope/telescope-file-browser.nvim'
    },
    {
        'nvim-telescope/telescope-media-files.nvim',
    },
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
    -- Logging framework
    -- Useful when debugging
    {
        'tjdevries/vlog.nvim',
    },
    -- Columnize selected lines
    {
       'jakeru/columnize.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('columnize').setup()
            vim.keymap.set("v", "<Leader>c", require('columnize').columnize,
                { desc = "Columnize selected lines" })
        end
    },
    -- Join selected lines
    {
        'jakeru/join.nvim',
        config = function()
            require('join').setup()
        end
    },
}
