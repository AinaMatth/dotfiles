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
			{ '<leader>f', group = 'Telescope', mode = { 'n', 'x' } },
			{ '<leader>b', group = 'Scratch Buffer', desc = "Scratch Buffer", icon = { icon = "", color = "cyan" } },
			{ '<leader>g', group = 'Git',mode = { 'n', 'v' } },
			{ '<leader>z', group = 'Zen', desc = "Zen Mode", icon = { icon = "󱅻", color = "purple" }, mode = { 'n', 'v' } },
		},
	},
}
