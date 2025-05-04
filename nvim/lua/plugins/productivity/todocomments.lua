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
  },
}
