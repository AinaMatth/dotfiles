return {
  {
    'tpope/vim-sleuth',
  },
  {
    'tpope/vim-fugitive',
    keys = {
      -- Core workflow
      { '<leader>gs', ':Git<CR>', desc = 'Git status' },
      { '<leader>ga', ':Git add %<CR>', desc = 'Git add current file' },
      { '<leader>gA', ':Git add .<CR>', desc = 'Git add all' },
      { '<leader>gc', ':Git commit<CR>', desc = 'Git commit' },
      { '<leader>gC', ':Git commit --amend<CR>', desc = 'Amend last commit' },
      { '<leader>gp', ':Git push<CR>', desc = 'Git push' },
      { '<leader>gP', ':Git pull<CR>', desc = 'Git pull' },

      -- Diff and review
      { '<leader>gd', ':Gdiffsplit<CR>', desc = 'Git diff (split)' },
      { '<leader>gD', ':Gvdiffsplit!<CR>', desc = 'Git diff vertical (force)' },
      { '<leader>gb', ':Git blame<CR>', desc = 'Git blame' },
      { '<leader>gL', ':0Gclog<CR>', desc = 'Git log for buffer' },
      { '<leader>gl', ':Git log<CR>', desc = 'Git log' },

      -- Branch & checkout
      { '<leader>gB', ':Git branch<CR>', desc = 'Git branches' },
      { '<leader>go', ':Git checkout ', desc = 'Git checkout (manual)' },

      -- Revert/reset
      { '<leader>gr', ':Gread<CR>', desc = 'Revert file (checkout HEAD)' },
      { '<leader>gR', ':Git reset<CR>', desc = 'Git reset' },

      -- Stash
      { '<leader>gS', ':Git stash<CR>', desc = 'Git stash' },
      { '<leader>gU', ':Git stash pop<CR>', desc = 'Git stash pop' },
    },
  },
}
