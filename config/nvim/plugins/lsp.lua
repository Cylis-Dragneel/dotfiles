local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local util = require("lspconfig/util")
lspconfig.nixd.setup({
  capabilities = capabilities,
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "nixfmt" },
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake "/home/cylis/cylisos/").nixosConfigurations.based.options',
        },
      },
    },
  },
})
lspconfig.gopls.setup({
  capabiltes = capabilites,
  command = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedPArams = true,
      },
    },
  },
})

lspconfig.html.setup({
  capabilities = capabilities,
})
lspconfig.lua_ls.setup({
  capabilities = capabilities,
})
lspconfig.basedpyright.setup({
  capabilities = capabilities,
})
lspconfig.marksman.setup({
  capabilities = capabilities,
})
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
})
lspconfig.yamlls.setup({
  capabilities = capabilities,
})
lspconfig.bashls.setup({
  capabilities = capabilities,
})
vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {})
