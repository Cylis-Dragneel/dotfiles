local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.html.setup({
  capabilities = capabilities
})
lspconfig.lua_ls.setup({
  capabilities = capabilities
})
lspconfig.pyright.setup({
  capabilities = capabilities
})
lspconfig.nil_ls.setup({
  capabilities = capabilities
})
lspconfig.marksman.setup({
  capabilities = capabilities
})
lspconfig.rust_analyzer.setup({
  capabilities = capabilities
})
lspconfig.yamlls.setup({
  capabilities = capabilities
})
lspconfig.bashls.setup({
  capabilities = capabilities
})
