local keymap = vim.keymap
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "leader>x", "<cmd>:BufferLinePickClose<CR>", { desc = "Close current split" }) -- close current split window
keymap.set("n", "<A-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Go Left"})
keymap.set("n", "<A-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Go Right"})
keymap.set("n", "<A-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Go Up"})
keymap.set("n", "<A-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Go Down"})
