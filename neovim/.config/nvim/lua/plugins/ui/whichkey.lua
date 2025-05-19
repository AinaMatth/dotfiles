return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    defaults = {},
    delay = 0,
    spec = {
      { mode = { 'n', 'v' }, { '<leader>f', group = 'file/find' } },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
