return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "bashls", "denols", "gopls", "jdtls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lspconfig = require("lspconfig")
      local util = require "lspconfig/util"
			lspconfig.lua_ls.setup({
        capabilities = capabilites
      })
			lspconfig.bashls.setup({
        capabilities = capabilites
      })
			lspconfig.denols.setup({
        capabilities = capabilites
      })
			lspconfig.gopls.setup({
        capabilities = capabilites,
        cmd = {"gopls"},
        filetypes = {"go", "gomod", "gowork", "gotmpl"},
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedParams = true,
            },
          },
        },
      })
      lspconfig.jdtls.setup({
        capabilities = capabilities
      })
			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {})
		end,
	},
}
