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

M.format_date = function(t)
    local days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
    local time = t and t or os.time()
    local weekday = tonumber(os.date("%w", time))
    return os.date("%Y-%m-%d ", time) .. days[weekday + 1]
end

M.format_date_swedish = function(t)
    local days = {"söndag", "måndag", "tisdag", "onsdag", "torsdag", "fredag", "lördag"}
    local time = t and t or os.time()
    local weekday = tonumber(os.date("%w", time))
    return os.date("%Y-%m-%d ", time) .. days[weekday + 1]
end

M.format_time = function (t)
    local time = t and t or os.time()
    return os.date("%H:%M", time)
end

return M
