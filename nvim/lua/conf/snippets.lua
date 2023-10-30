local ls_loaded, ls = pcall(require, 'luasnip')

if not ls_loaded then
    print("Failed to load luasnip")
    return
end

vim.keymap.set({"i"}, "<C-l>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-k>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-j>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-u>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

require('luasnip.loaders.from_vscode').lazy_load()

