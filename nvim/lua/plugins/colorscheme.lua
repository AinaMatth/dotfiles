return {
	"folke/tokyonight.nvim",
	lazy = true,
	priority = 1000,
	opts = {},
	init = function()
		vim.cmd([[colorscheme tokyonight-storm]])
	end,
}
