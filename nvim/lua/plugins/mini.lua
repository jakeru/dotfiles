local M = {}

M.setup_pick = function()
    require('mini.pick').setup({
        mappings = {
            refine = "<S-CR>",
            toggle_preview = "<Tab>",
            toggle_info = "<S-Tab>",
        }
    })

    local jlib = require("jlib")
    local MiniPick = require("mini.pick")

    local ripgrep = function()
        -- Options for grep_live:
        --   cwd: Directory to search in (defaults to current working directory)
        --   globs: Array of glob patterns to limit file types
        -- Example: { cwd = '/path/to/dir', globs = { '*.lua' } }
        -- As a user, press C-o to specify the file patterns to search in.
        print("cwd: " .. vim.fn.getcwd())
        MiniPick.builtin.grep_live({
            -- cwd = vim.fn.getcwd(),  -- Use current directory (default)
            -- cwd = '/path/to/directory',  -- Search in specific directory
            -- globs = { '*.lua', '*.js' }  -- Limit to specific file patterns
        })
    end

    jlib.nmap("<Leader>rg", ripgrep, "Ripgrep search with mini.pick")

    local ripgrep_files = function()
        -- Search for files containing a pattern (lists files only, not lines)
        -- Uses ripgrep's -l option to list only filenames with matches
        MiniPick.builtin.grep_live({
            tool = 'rg',
            args = { '--files-with-matches' }, -- List only filenames with matches
            -- cwd = vim.fn.getcwd(),  -- Use current directory (default)
            -- cwd = '/path/to/directory',  -- Search in specific directory
            -- globs = { '*.lua', '*.js' }  -- Limit to specific file patterns
        })
    end

    jlib.nmap("<Leader>rf", ripgrep_files, "Find files matching pattern (files only)")

    local find_files = function()
        -- Options for files:
        --   cwd: Directory to search in (defaults to current working directory)
        --   tool: Tool to use ('find', 'fd', 'git', 'rg') - defaults to 'find'
        MiniPick.builtin.files({
            -- cwd = vim.fn.getcwd(),  -- Use current directory (default)
            -- cwd = '/path/to/directory',  -- Search in specific directory
            -- tool = 'fd',  -- Use 'fd' instead of 'find' (faster, if available)
        })
    end

    jlib.nmap("<Leader>pf", find_files, "Find files with mini.pick")
end

M.setup = function()
    require("mini.files").setup({
        options = {
            permanent_delete = false,
        },
        windows = {
            preview = true,
        }
    })

    require("mini.icons").setup()

    local jlib = require("jlib")

    local minifiles_toggle = function()
        if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
    end

    jlib.nmap("<Leader>fe", minifiles_toggle, "Open mini.files")

    require("mini.ai").setup()

    require('mini.move').setup({
        mappings = {
            left  = 'H',
            right = 'L',
            down  = 'J',
            up    = 'K',
        }
    })

    -- Trailspace
    require("mini.trailspace").setup()

    local trim = function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
    end

    local desc = "Trim trailing whitespace and lines"

    vim.api.nvim_create_user_command("Trim", trim, { desc = desc })
    jlib.nmap("<Leader>lt", trim, desc)

    M.setup_pick()
end

M.plugins = {
    'nvim-mini/mini.nvim',
    -- "*" for stable branch
    -- false for main branch (latest)
    version = "*",
    config = M.setup,
}

return M.plugins
