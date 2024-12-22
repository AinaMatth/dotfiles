return {
	'folke/which-key.nvim',
	event = 'VimEnter',
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	opts = {
		preset = 'helix',
		icons = {
			mappings = vim.g.have_nerd_font,
			keys = {},
		},
		spec = {
			{ '<leader>s', group = 'Telescope', mode = { 'n', 'x' } },
			{ '<leader>g', group = 'Git',mode = { 'n', 'v' } },
		},
	},
}
