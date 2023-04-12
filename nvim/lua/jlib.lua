local keymap = function(mode, k, v, desc)
    -- Available modes:
    --  normal_mode = "n",
    --  insert_mode = "i",
    --  visual_mode = "v",
    --  visual_block_mode = "x",
    --  term_mode = "t",
    --  command_mode = "c",
    vim.keymap.set(mode, k, v, { desc = desc })
end

local M = {}

M.map = function(mode, k, v, desc)
    keymap(mode, k, v, desc)
end

M.nmap = function(k, v, desc)
    keymap('n', k, v, desc)
end

return M
