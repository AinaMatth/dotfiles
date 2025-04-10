-- -- Autocompletion
return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets' },
	event = 'InsertEnter',
	version = '1.*',
	build = 'cargo build --release',

	---@module 'blink.cmp'
	opts = {
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = { preset = 'default' },

		appearance = {
			nerd_font_variant = 'mono',
		},
		completion = { documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = 'single' } } },
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
		fuzzy = { implementation = 'prefer_rust_with_warning' },
	},
	opts_extend = { 'sources.default' },
}
