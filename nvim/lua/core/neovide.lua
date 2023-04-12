-- Neovide specific configuration
-- Inspiration from Andreas at:
-- https://github.com/Skosulor/dotfiles

if not vim.g.neovide then
    return
end

vim.o.guifont = 'FiraCode Nerd Font:h10'

vim.g.neovide_scroll_animation_length = 0.5
vim.g.neovide_hide_mouse_when_typing = true

vim.g.neovide_scale_factor = 1.0

local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

local jlib = require('jlib')

jlib.nmap("<C-+>", function()
    change_scale_factor(1.10)
end)

jlib.nmap("<C-->", function()
    change_scale_factor(1 / 1.10)
end)

jlib.nmap("<C-=>", function()
    vim.g.neovide_scale_factor = 1.0
end)
