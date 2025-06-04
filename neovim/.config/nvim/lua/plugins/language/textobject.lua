return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  branch = 'main',
  config = function()
    require('nvim-treesitter.config').setup {}
  end,
}
