local ls_loaded, ls = pcall(require, 'luasnip')

if not ls_loaded then
    print("Failed to load luasnip")
    return
end

require("luasnip.loaders.from_vscode").lazy_load()

