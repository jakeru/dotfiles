local M = {}

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

    -- Trailspace
    require("mini.trailspace").setup()

    local trim = function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
    end

    local desc = "Trim trailing whitespace and lines"

    vim.api.nvim_create_user_command("Trim", trim, { desc = desc })
    jlib.nmap("<Leader>lt", trim, desc)
end

M.plugins = {
    'echasnovski/mini.nvim',
    -- "*" for stable branch
    -- false for main branch (latest)
    version = "*",
    config = M.setup,
}

return M.plugins
