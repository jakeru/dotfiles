return {
    {
        'folke/neoconf.nvim',
        cmd = "Neoconf"
    },
    {
        'folke/neodev.nvim',
        config = true,
    },
    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({
            })
        end,
    },
    {
        'ziontee113/color-picker.nvim',
        cmd = 'PickColor',
        config = true,
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
        -- Example of usage:
        -- :Bufferize messages
        -- :Bufferize digraphs
        -- :Bufferize map
        -- :Bufferize command
        'AndrewRadev/bufferize.vim'
    },
    {
        'wesleimp/stylua.nvim'
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
        'phaazon/hop.nvim',
    },
    -- Quickly jump between buffers
    {
        'ThePrimeagen/harpoon',
        dependencies = 'nvim-lua/plenary.nvim',
    },
    -- Add indentation guides even on blank lines
    {
        'lukas-reineke/indent-blankline.nvim',
        -- See `:help indent_blankline.txt`
        config = function()
            require('indent_blankline').setup({
                char = '┊',
                show_trailing_blankline_indent = false
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
    -- Trim trailing spaces
    {
        'lewis6991/spaceless.nvim',
        config = true
    },
    -- Syntax highlighting using tree-sitter
    {
        'nvim-treesitter/nvim-treesitter',
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require('nvim-treesitter.configs').setup({})
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
    },
    {
        'nvim-treesitter/playground',
    },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP.
            {
                'j-hui/fidget.nvim',
                config = true,
            },
        },
    },
    -- Autocompletion and snippets
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
        },
    },
    -- A bunch of snippets from different programming languages
    {
        '/rafamadriz/friendly-snippets',
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
    -- Project
    {
        "ahmedkhalf/project.nvim",
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
    -- LSP Zero
    --[[ {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            -- {'hrsh7th/cmp-buffer'},       -- Optional
            -- {'hrsh7th/cmp-path'},         -- Optional
            -- {'saadparwaiz1/cmp_luasnip'}, -- Optional
            -- {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            -- {'rafamadriz/friendly-snippets'}, -- Optional
        }
    }, ]]
}
