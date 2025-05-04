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
      ']t',
      function()
        require('todo-comments').jump_next()
      end,
      desc = 'Next Todo Comment',
    },
    {
      '[t',
      function()
        require('todo-comments').jump_prev()
      end,
      desc = 'Previous Todo Comment',
    },
    { '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = 'Todo (Trouble)' },
    {
      '<leader>xT',
      '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>',
      desc = 'Todo/Fix/Fixme (Trouble)',
    },
    {
      '<leader>ft',
      function()
        Snacks.picker.todo_comments { keywords = { 'TODO', 'HACK', 'WARNING', 'BUG', 'NOTE', 'INFO', 'PERF', 'ERROR' } }
      end,
      desc = 'Todo Comment Tags',
    },
    {
      '<leader>fT',
      function()
        Snacks.picker.todo_comments()
      end,
      desc = 'Todo',
    },
  },
}
