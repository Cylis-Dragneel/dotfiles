require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "html", "rust", "java", "javascript", "scss", "yuck", "html", "css" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
