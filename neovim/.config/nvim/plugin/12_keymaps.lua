local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General

keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window Navigation

keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move to left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move to right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move to lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move to upper window' })

-- better up/down
keymap({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
keymap({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
keymap({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
keymap({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- better search
keymap('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
keymap('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
keymap('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
keymap('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
keymap('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
keymap('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
-- Keeping the cursor centered.
keymap('n', '<C-d>', '<C-d>zz', { desc = 'Scroll downwards' })
keymap('n', '<C-u>', '<C-u>zz', { desc = 'Scroll upwards' })
keymap('n', 'n', 'nzzzv', { desc = 'Next result' })
keymap('n', 'N', 'Nzzzv', { desc = 'Previous result' })

-- Window Resizing

keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- LSP Keymaps

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

-- Mini Keymaps
keymap('n', '<leader>z', '<cmd>Zoom<cr>', { desc = 'Zoom current buffer' })
keymap('n', '<leader>bD', function()
  require('mini.bufremove').delete(0, false)
end, { desc = 'Delete current buffer' })
keymap('n', '<leader>tf', '<cmd>MiniMap.toggle_focus<cr>', { desc = 'MiniMap.toggle_focus' })
keymap('n', '<leader>ts', '<cmd>MiniMap.toggle_focus<cr>', { desc = 'MiniMap.toggle_side' })
keymap('n', '<leader>tt', '<cmd>MiniMap.toggle_focus<cr>', { desc = 'MiniMap.toggle' })
keymap('n', 'RR', 'R', { desc = 'Replace mode' })
keymap('n', '<leader>ed', '<cmd>lua MiniFiles.open()<CR>', { desc = 'Directory' })
keymap('n', '<leader>ef', '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', { desc = 'File Directory' })
keymap('n', '<leader><leader>', '<cmd>Pick buffers<cr>', { desc = 'Buffers' })
keymap('n', '<leader>sf', '<cmd>Pick files<cr>', { desc = 'Files' })
keymap('n', '<leader>sh', '<cmd>Pick help<cr>', { desc = 'Help' })
keymap('n', '<leader>sl', '<cmd>Pick buf_lines scope="all"<cr>', { desc = 'Lines (all)' })
keymap('n', '<leader>sL', '<cmd>Pick buf_lines scope="current"<cr>', { desc = 'Lines (current)' })
keymap('n', '<leader>sg', '<cmd>Pick grep_live<cr>', { desc = 'Grep live' })
keymap('n', '<leader>ss', '<cmd>Pick lsp scope="workspace_symbol"<cr>', { desc = 'Symbols workspace (LSP)' })
keymap('n', '<leader>sr', '<cmd>Pick lsp scope="references"<cr>', { desc = 'References (LSP)' })
keymap('n', '<leader>sS', '<cmd>Pick lsp scope="document_symbol"<cr>', { desc = 'Symbols buffers (LSP)' })
keymap('n', '<leader>sd', '<cmd>Pick diagnostic scope="all"<CR>', { desc = 'Diagnostic workspace' })
keymap('n', '<leader>sb', '<cmd>Pick diagnostic scope="current"<CR>', { desc = 'Diagnostic buffer' })
