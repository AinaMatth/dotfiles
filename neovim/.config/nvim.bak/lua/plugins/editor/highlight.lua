return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {},
  keys = {
    { '<leader>tc', '<cmd>ColorizerToggle<CR>', desc = 'Toggle colorizer' },
  },
}
