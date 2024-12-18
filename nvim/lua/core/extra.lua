local function create_user_command(name, expand_str)
    vim.api.nvim_create_user_command(name, function()
        local str = vim.fn.expand(expand_str)
        vim.fn.setreg("+", str)
        vim.notify('Copied "' .. str .. '" to the clipboard')
    end, {})
end

create_user_command("CopyPath", "%:p")
create_user_command("CopyRelPath", "%:~:.")
create_user_command("CopyFileTitle", "%:t")

-- Enable word wrapping for some file types
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'markdown', 'text', 'gitcommit' },
    callback = function()
        vim.opt_local.textwidth = 80
    end
})

-- Enable spell checking for some file types.
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'markdown', 'text', 'gitcommit', 'rust', 'python', 'typst' },
    callback = function()
        vim.opt_local.spell = true
    end
})

-- Find the number of the last non empty line (zero-based).
local function find_last_non_empty_line(buffer)
    local line_count = vim.api.nvim_buf_line_count(buffer)
    local i = line_count - 1
    while i > 0 do
        local line = vim.api.nvim_buf_get_lines(buffer, i, i + 1, true)[1]
        if string.len(line) > 0 then
            break
        end
        i = i - 1
    end
    return i
end

-- Notes about kitty:
        -- When launched from kitty, the environment variable KITTY_PIPE_DATA
        -- will contain:
        -- {scrolled_by}:{cursor_x},{cursor_y}:{lines},{columns}
        -- as explained here:
        -- https://sw.kovidgoyal.net/kitty/launch/
        -- Example:
        -- 0:3,36:73,126
        -- This snippet of code sets the cursor at that position.
        -- Note that the position only makes sense when using @screen
        -- as source.
        -- I have not figured out the right way to do this when the
        -- stdin source is @screen_scrollback.

        -- local str = os.getenv('KITTY_PIPE_DATA')
        -- if str then
        --     vim.notify("Found KITTY_PIPE_DATA: " .. str)
        --     local args = {}
        --     for arg in string.gmatch(str, '([^,:]+)') do
        --         args[#args + 1] = arg
        --     end
        --     local cursor_x = tonumber(args[2])
        --     local cursor_y = tonumber(args[3])
        --     vim.notify("cursor_x: " .. tostring(cursor_x))
        --     vim.notify("cursor_y: " .. tostring(cursor_y))
        --     -- vim.api.nvim_win_set_cursor(0, { cursor_y, cursor_x - 1 })

-- When opening something from stdin:
-- Set cursor position at the end of last non-empty line.
-- Mark the buffer as unmodified.
vim.api.nvim_create_autocmd('StdinReadPost', {
    callback = function()
        local buffer = 0
        local last_line = find_last_non_empty_line(buffer)
        local line = vim.api.nvim_buf_get_lines(buffer, last_line, last_line + 1, true)[1]
        local length = string.len(line)
        vim.api.nvim_win_set_cursor(0, { last_line + 1, length } )
        vim.opt_local.modified = false
    end
})
