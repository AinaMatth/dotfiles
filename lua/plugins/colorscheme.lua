return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  opts = {
    compile = true,
    commentStyle = { italic = false },
  },
  config = function(_, opts)
    require('kanagawa').setup(opts)
    vim.cmd 'colorscheme kanagawa'
  end,
}
