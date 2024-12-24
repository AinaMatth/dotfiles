return {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = {
		style = "moon",
	},
	config = function()
		vim.cmd("colorscheme tokyonight")
	end,
}
