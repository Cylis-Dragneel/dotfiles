require("lualine").setup({
  icons_enabled = true,
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_z = { "location" },
  },
})
