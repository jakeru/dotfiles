-- Base configuration from the plugin lsp-zero itself:
-- https://github.com/VonHeikemen/lsp-zero.nvim

-- To see current language servers, use:
-- :Mason

-- Install new language servers using the command:
-- :LspInstall

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
