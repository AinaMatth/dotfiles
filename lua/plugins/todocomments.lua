return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    keywords = {
      TEST = { icon = '󱎫', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
    },
  },
  keys = {
    {
      '<leader>st',
      function()
        Snacks.picker.todo_comments { keywords = { 'TODO', 'HACK', 'WARNING', 'BUG', 'NOTE', 'INFO', 'PERF', 'ERROR' } }
      end,
      desc = 'Todo Comment Tags',
    },
    {
      '<leader>sT',
      function()
        Snacks.picker.todo_comments()
      end,
      desc = 'Todo',
    },
  },
}
