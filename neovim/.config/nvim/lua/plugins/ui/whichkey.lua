return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    preset = 'modern',
    delay = 0,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {},
    },
    spec = {
      {
        mode = { 'n', 'v' },
        { '<leader>c', group = 'code' },
        { '<leader>f', group = 'file/find' },
        { '<leader>h', group = 'hunks', icon = { icon = '', color = 'grey' } },
        { '<leader>q', group = 'quarto', icon = { icon = '󰙵 ', color = 'lightblue' } },
        { '<leader>s', group = 'TODO', icon = { icon = '󱖫 ', color = 'lightgreen' } },
        { 'g', group = 'goto' },
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
