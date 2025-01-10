return {
    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup()
        end,
    },
    {
        'kylechui/nvim-surround',
    },
    -- An alternative file explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        version = "v2.x",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
    },
    -- Quickly switch between number formats hex/dec/bin
    {
        'skosulor/nibbler',
        config = true,
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
        'nvim-treesitter/nvim-treesitter-textobjects',
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
    -- Autocompletion and snippets
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim',
        },
    },
    {
        'L3MON4D3/LuaSnip',
        tag = "v2.0.0",
    },
    -- A bunch of snippets from different programming languages
    {
        'rafamadriz/friendly-snippets',
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
