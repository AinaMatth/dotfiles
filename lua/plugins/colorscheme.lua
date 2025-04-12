return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  opts = {
    compile = true,
    commentStyle = { italic = false },
  },
  config = function()
    vim.cmd 'colorscheme kanagawa'
  end,
}
