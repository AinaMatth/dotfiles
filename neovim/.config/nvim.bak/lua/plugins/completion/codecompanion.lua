return {
  'olimorris/codecompanion.nvim',
  cmd = 'CodeCompanion',
  opts = {},
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { 'markdown', 'codecompanion' },
    },
  },
  keys = {
    {
      '<leader>cc',
      '<cmd>:CodeCompanionChat<CR>',
      desc = 'Code Companion Chat',
    },
    {
      '<leader>ca',
      '<cmd>:CodeCompanionactions<CR>',
      desc = 'Code Companion Actions',
    },
  },
}
