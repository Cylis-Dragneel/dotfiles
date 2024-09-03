local supermaven = require("supermaven-nvim")
supermaven.setup({
      keymaps = {
	 accept_suggestion = "<Tab>",
	 clear_suggestion = "<C-]>",
	 accept_word = "<C-j>",
      },
      log_level = "off", -- set to "off" to disable logging completely
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false -- disables built in keymaps for more manual control
})
