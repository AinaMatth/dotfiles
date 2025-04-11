return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		float = {
			win_options = {
				number = false,
				relativenumber = false,
			},
		},
	},
	dependencies = { { 'nvim-tree/nvim-web-devicons', opts = {} } },
	lazy = false,
}
