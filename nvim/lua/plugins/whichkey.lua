return {
	'folke/which-key.nvim',
	event = 'VimEnter',
	opts = {
		preset = 'helix',
		icons = {
			mappings = vim.g.have_nerd_font,
			keys = {},
		},
	},
	specs = {},
}
