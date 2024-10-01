return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    require("dapui")
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
    vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<Leader>dc", dap.continue, {})
    -- vim.keymap.set("n", "<Leader>du", function()
    --   local widgets = require("dap.ui.widgets")
    --   local sidebar = widgets.sidebar(widgets.scopes)
    --   sidebar.open()
    -- end, {})
    -- vim.keymap.set("n", "<Leader>gt", dap_go.debug_test(), {})
    -- vim.keymap.set("n", "<Leader>gl", dap_go.debug_last(), {})
  end,
}
