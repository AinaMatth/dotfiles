-- NOTE: Keymaps
local map = vim.keymap.set

-- mini.files
map('n', '-', function()
  require('mini.files').open()
end, { desc = 'File [E]xplorer' })

-- mini.pick
-- Top pickers

map('n', '<leader>sf', '<cmd>Pick files<cr>', { desc = '[S]earch [F]iles' })
map(
  'n',
  '<leader>sc',
  'MiniPick.builtin.files(nil, { source = { cwd = vim.fn.stdpath("config") } })',
  { desc = '[S]earch [N]eovim' }
)
map('n', '<leader>sg', '<cmd>Pick grep_live<cr>', { desc = '[S]earch by [G]rep' })
map('n', '<leader>,', '<cmd>Pick buffers<cr>', { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', '<cmd>Pick buf_lines<cr>', { desc = '[/] Fuzzily search in current buffer' })
map('n', '<leader>s.', '<cmd>Pick oldfiles<cr>', { desc = '[S]earch Recent Files ("." for repeat)' })
map('n', '<leader>sh', '<cmd>Pick help<cr>', { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', '<cmd>Pick keymaps<cr>', { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sd', '<cmd>Pick diagnostic<cr>', { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sw', '<cmd>Pick grep<cr>', { desc = '[S]earch current [W]ord' })

-- git
map('n', '<leader>gc', '<cmd>Pick git_commits<cr>', { desc = 'Git Commits' })
map('n', '<leader>gb', '<cmd>Pick git_branches<cr>', { desc = 'Git Branches' })
map('n', '<leader>gh', '<cmd>Pick git_hunks<cr>', { desc = 'Git Hunks' })

map('n', 'grn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
map({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, { desc = '[G]oto Code [A]ction' })
map('n', 'gO', "<Cmd>Pick lsp scope='document_symbol'<CR>", { desc = 'Open document symbols' })
map('n', 'gW', "<Cmd>Pick lsp scope='workspace_symbol'<CR>", { desc = 'Open workspace symbols' })
map('n', 'grr', "<Cmd>Pick lsp scope='references'<CR>", { desc = '[R]eferences' })
map('n', 'gri', "<Cmd>Pick lsp scope='implementation'<CR>", { desc = '[I]mplementation' })
map('n', 'grd', "<Cmd>Pick lsp scope='definition'<CR>", { desc = '[G]oto [D]efinition' })
map('n', 'grD', "<Cmd>Pick lsp scope='declaration'<CR>", { desc = '[G]oto [D]eclaration' })
map('n', 'grt', "<Cmd>Pick lsp scope='type_definition'<CR>", { desc = '[G]oto [T]ype Definition' })
