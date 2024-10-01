return {
	"olexsmir/gopher.nvim",
	config = function()
		require("gopher").setup({})
	end,
	build = function()
		vim.cmd(GoInstallDeps)
	end,
}
