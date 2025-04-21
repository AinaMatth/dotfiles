return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    preset = 'helix',
    defaults = {},
    spec = {
      {
        mode = { 'n', 'v' },
        { '<leader>c', group = 'code' },
        { '<leader>d', group = 'debug' },
        { '<leader>dp', group = 'profiler' },
        { '<leader>f', group = 'file/find' },
        { '<leader>g', group = 'git', icon = { icon = '󰊢', color = 'red' } },
        { '<leader>h', group = 'hunks', icon = { icon = '', color = 'grey' } },
        { '<leader>s', group = 'search' },
        { '<leader>u', group = 'ui', icon = { icon = '󰙵 ', color = 'cyan' } },
        { '<leader>x', group = 'diagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
        { '[', group = 'prev' },
        { ']', group = 'next' },
        { 'g', group = 'goto' },
        { 'gs', group = 'surround' },
        { 'z', group = 'fold' },
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
      desc = 'Buffer Keymaps (which-key)',
    },
  },
}
