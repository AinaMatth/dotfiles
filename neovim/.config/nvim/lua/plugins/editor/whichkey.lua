return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts_extend = { 'spec' },
  opts = {
    preset = 'helix',
    defaults = {},
    delay = 0,
    spec = {
      {
        mode = { 'n', 'v' },
        { '<leader>', group = 'Leader', icon = { icon = '󰓎 ', color = 'yellow' } },
        { '<leader>c', group = 'code' },
        { '<leader>x', group = 'diagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
        { '<leader>s', group = '[F]zF', icon = { icon = ' ', color = 'white' } },
        { '<leader>g', group = 'Git [H]unk' },
        { 'gx', desc = 'Open with system app' },
      },
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
