local dap = require("dap")
local dapui = require("dapui")

require("dapui").setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

dap.adapters.bashdb = {
  type = 'executable';
  command = 'bashdb';
  name = 'bashdb';
}

dap.configurations.sh = {
    type = 'bashdb';
    request = 'launch';
    name = "Launch file";
    showDebugOutput = true;
    pathBashdb = 'bashdb';
    trace = true;
    file = "${file}";
    program = "${file}";
    cwd = '${workspaceFolder}';
    pathCat = "bat";
    pathBash = "/usr/bin/env bash";
    pathMkfifo = "mkfifo";
    pathPkill = "pkill";
    args = {};
    env = {};
    terminalKind = "integrated";
}

vim.keymap.set("n", "<Leader>dt", "<cmd>DapToggleBreakpoint<CR>", {})
vim.keymap.set("n", "<Leader>dc", "<cmd>DapContinue<CR>", {})
