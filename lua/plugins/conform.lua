-- Autoformat
return {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	opts = {
		formatters_by_ft = {
			javascript = { 'biome' },
			typescript = { 'biome' },
			javascriptreact = { 'biome' },
			typescriptreact = { 'biome' },
			svelte = { 'prettierd' },
			css = { 'biome' },
			html = { 'biome' },
			json = { 'biome' },
			jsonc = { 'biome' },
			lua = { 'stylua' },
			rust = { 'rustfmt', lsp_format = 'fallback' },
			python = { 'isort', 'black' },
		},
		format_on_save = {
			timeout_ms = 500,
			async = false,
			lsp_format = 'fallback',
		},
	},
}
