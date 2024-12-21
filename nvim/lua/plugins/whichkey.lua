return {
	'folke/which-key.nvim',
	event = 'VimEnter',
	opts = {
		preset = 'helix',
		icons = {
			mappings = vim.g.have_nerd_font,
			keys = {},
		},
		spec = {
			{ '<leader>f', group = 'Find', mode = { 'n', 'x' } },
			{ '<leader>b', group = 'Scratch Buffer', desc = "Scratch Buffer", icon = { icon = "", color = "cyan" } },
			{ '<leader>G', group = 'Git', desc = "Git", icon = { icon = "󰊢", color = 'orange' }, mode = { 'n', 'v' } },
			{ '<leader>z', group = 'Zen', desc = "Zen Mode", icon = { icon = "󱅻", color = "purple" }, mode = { 'n', 'v' } },
		},
	},
}
