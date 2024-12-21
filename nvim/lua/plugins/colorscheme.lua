return {
  "folke/tokyonight.nvim",
  lazy = true,
  priority = 1000,
  opts = {
		style = 'storm',
	},
	init = function()
		vim.cmd[[colorscheme tokyonight]]
	end,
}
