return {
	'mfussenegger/nvim-lint',
	event = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
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
}
