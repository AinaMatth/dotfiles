return {
	"ibhagwan/fzf-lua",
	event = 'VimEnter',
	-- optional for icon support
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local fzf = require('fzf-lua')
		local key = vim.keymap.set

		-- Key mapping for finding files
		key('n', '<leader>ff', fzf.files, { desc = 'Fzf files' })
		key('n', '<leader>fq', fzf.quickfix, { desc = 'Fzf quickfix' })
		key('n', '<leader>fg', fzf.live_grep, { desc = 'Fzf grep' })
		key('n', '<leader>fh', fzf.helptags, { desc = 'Fzf helptags' })
	end,
}
