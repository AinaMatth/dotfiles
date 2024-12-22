require('core.options')
require('core.keymaps')

-- Highlight text on Yank

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank {higroup= highlight_group,pattern = '*',timeout=300}
  end,
})

require('core.lazy')
