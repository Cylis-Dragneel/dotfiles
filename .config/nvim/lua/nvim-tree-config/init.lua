vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  view = {
    width = 25,
  },
  git = {
    enable = true,
  },
  filters = {
    enable = true,
    git_ignored = true
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
})

