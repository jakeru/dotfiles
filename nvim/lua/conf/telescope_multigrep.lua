-- Inspiration from:
-- TJ DeVries YouTube video Advanced telescope.nvim Examples:
-- https://www.youtube.com/watch?v=xdXE1tOT-qg

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local M = {}

M.multigrep = function(opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.uv.cwd()

    local finder = finders.new_async_job({
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end

            local pieces = vim.split(prompt, "  ")
            local args = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case"
            }
            if pieces[1] then
                table.insert(args, "--regexp")
                table.insert(args, pieces[1])
            end
            if pieces[2] then
                table.insert(args, "--glob")
                table.insert(args, pieces[2])
            end

            return args
        end,
        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
    })

    pickers.new(opts, {
        debounce = 100,
        prompt_title = "Multi Grep - Use double space to separate pattern with file glob",
        finder = finder,
        previewer = conf.grep_previewer(opts),
        sorter = require("telescope.sorters").empty(),
    }):find()
end

return M
