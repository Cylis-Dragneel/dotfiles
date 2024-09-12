local wk = require("which-key")
wk.add({
    { "<leader>Q", "<cmd>q!<CR>", desc = "Quit without saving" },
    { "<leader>W", "<cmd>w<CR>", desc = "Write" },
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Tree Explorer" },
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>l", group = "LSP" },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Connected Language Servers" },
    { "<leader>q", "<cmd>q<CR>", desc = "Quit" },
    { "<leader>r", group = "prefix" },
    { "<leader>rf", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
    { "<leader>rn", "<cmd>set relativenumber<CR>", desc = "Turn on relative numbers" },
    { "<leader>x", "<cmd>bdelete<CR>", desc = "Close Buffer" },
    -- { "<leader>z", group = "Focus" },
    -- { "<leader>zt", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    -- { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
})
    -- k = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
    -- K = { "<cmd>Lspsaga hover_doc<cr>", "Hover Commands" },
    -- w = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', "Add Workspace Folder" },
    -- W = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', "Remove Workspace Folder" },
    -- l = {
    --   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
    --   "List Workspace Folders"
    -- },
    -- t = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', "Type Definition" },
    -- d = { '<cmd>lua vim.lsp.buf.definition()<cr>', "Go To Definition" },
    -- D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', "Go To Declaration" },
    -- r = { '<cmd>lua vim.lsp.buf.references()<cr>', "References" },
    -- R = { '<cmd>Lspsaga rename<cr>', "Rename" },
    -- a = { '<cmd>Lspsaga code_action<cr>', "Code Action" },
    -- e = { '<cmd>Lspsaga show_line_diagnostics<cr>', "Show Line Diagnostics" },
    -- n = { '<cmd>Lspsaga diagnostic_jump_next<cr>', "Go To Next Diagnostic" },
    -- N = { '<cmd>Lspsaga diagnostic_jump_prev<cr>', "Go To Previous Diagnostic" }
