return {
	-- LSP, DAP, Linters, Formatters Manager
	{
		'williamboman/mason.nvim',
		cmd = 'Mason',
		keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
		build = ':MasonUpdate',
		config = true,
	},

	-- Autoformat
	{
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
	},
	-- -- Autocompletion
	{
		'saghen/blink.cmp',
		dependencies = { 'rafamadriz/friendly-snippets' },
		event = 'InsertEnter',
		version = '1.*',
		build = 'cargo build --release',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = 'default' },

			appearance = {
				nerd_font_variant = 'mono',
			},
			completion = { documentation = { auto_show = false } },
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
				fuzzy = { implementation = 'prefer_rust' },
			},
		},

		-- Pretty Diagnostics
		{
			'folke/trouble.nvim',
			opts = {},
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

		{
			'mfussenegger/nvim-lint',
			event = { 'BufReadPre', 'BufNewFile' },
			config = function()
				local lint = require 'lint'

				lint.linters_by_ft = {
					javascript = { 'eslint_d' },
					typescript = { 'eslint_d' },
					javascriptreact = { 'eslint_d' },
					typescriptreact = { 'eslint_d' },
					svelte = { 'eslint_d' },
					python = { 'ruff' },
				}

				local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

				vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
					group = lint_augroup,
					callback = function()
						if vim.opt_local.modifiable:get() then
							lint.try_lint()
						end
					end,
				})

				vim.keymap.set('n', '<leader>li', function()
					lint.try_lint()
				end, { desc = 'Trigger linting for current file' })
			end,
		},
	},
}
