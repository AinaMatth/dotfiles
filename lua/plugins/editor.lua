return {
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	-- Pretty Diagnostics
	{
		'folke/trouble.nvim',
		opts = {
			modes = {
				lsp = {
					win = { position = 'right' },
				},
			},
		},
		cmd = 'Trouble',
		keys = {
			{
				'<leader>xx',
				'<cmd>Trouble diagnostics toggle<cr>',
				desc = 'Diagnostics (Trouble)',
			},
			{
				'<leader>xX',
				'<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
				desc = 'Buffer Diagnostics (Trouble)',
			},
			{
				'<leader>xq',
				'<cmd>Trouble qflist toggle<cr>',
				desc = 'Quickfix List (Trouble)',
			},
		},
	},
}
