return {
	'williamboman/mason.nvim',
	cmd = 'Mason',
	keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
	build = ':MasonUpdate',
	opts = { ensure_installed = { 'biome', 'stylua', 'black', 'ruff', 'isort', 'prettierd', 'shfmt' } },
}
