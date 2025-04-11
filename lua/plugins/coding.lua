return {
	{
		'echasnovski/mini.pairs',
		event = 'VeryLazy',
		opts = {
			modes = { insert = true, command = true, terminal = false },
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			skip_ts = { 'string' },
			skip_unbalanced = true,
			markdown = true,
		},
		config = function()
			require('mini.pairs').setup()
		end,
	},
	{
		'folke/lazydev.nvim',
		ft = 'lua',
		cmd = 'LazyDev',
		opts = {
			library = {
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			},
		},
	},
}
