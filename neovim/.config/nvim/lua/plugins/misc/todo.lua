return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    keywords = {
      PERF = { icon = '󰓅 ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
      NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
      TEST = { icon = '󰥔', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
    },
  },
  keys = {
    {
      '<leader>st',
      function()
        require('todo-comments.fzf').todo()
      end,
      desc = 'Todo',
    },
    {
      '<leader>sT',
      function()
        require('todo-comments.fzf').todo { keywords = { 'TODO', 'FIX', 'FIXME' } }
      end,
      desc = 'Todo/Fix/Fixme',
    },
  },
}
