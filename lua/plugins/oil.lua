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
	dependencies = { { 'echasnovski/mini.icons', opts = {} } },
	lazy = false,
}
