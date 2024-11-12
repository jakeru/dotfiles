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
