-- Neovide specific configuration
-- Inspiration from Andreas at:
-- https://github.com/Skosulor/dotfiles

if not vim.g.neovide then
    return
end

print("Neovide detected")

vim.o.guifont = 'FiraCode Nerd Font:h10'

vim.g.neovide_position_animation_length = 0.15
vim.g.neovide_scroll_animation_length = 0.1
vim.g.neovide_hide_mouse_when_typing = true

vim.g.neovide_scale_factor = 1.0

local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

local jlib = require('jlib')

jlib.nmap("<C-_>", function()
    change_scale_factor(1.10)
end, "Increase font size")

jlib.nmap("<C-->", function()
    change_scale_factor(1 / 1.10)
end, "Decrease font size")

jlib.nmap("<C-=>", function()
    vim.g.neovide_scale_factor = 1.0
end, "Reset font size")
