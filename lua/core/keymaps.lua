local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- General
-- ============================================================================

keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
keymap('n', 'w', ':w', { desc = 'Saeve file' })
keymap('n', 'q', ':q', { desc = 'Quit file' })
keymap('n', 'vs', ':vs', { desc = 'Vertical split' })

-- ============================================================================
-- Window Navigation
-- ============================================================================

keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move to left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move to right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move to lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move to upper window' })

-- ============================================================================
-- Window Resizing
-- ============================================================================

keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- ============================================================================
-- LSP Keymaps
-- ============================================================================

keymap('n', 'K', vim.lsp.buf.hover, { desc = 'LSP Hover' })
keymap('n', 'gf', function()
  vim.lsp.buf.format { async = true }
end, { desc = 'LSP Format' })
keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
keymap('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to Declaration' })
keymap('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
keymap('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Type Definition' })
keymap('n', 'gn', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
keymap('n', 'ga', vim.lsp.buf.code_action, { desc = 'Code Action' })
keymap('n', 'gr', vim.lsp.buf.references, { desc = 'References' })
