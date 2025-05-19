return {
  'webhooked/kanso.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('kanso').setup {
      compile = true,
      commentStyle = { italic = false },
      transparent = true,
    }
    vim.cmd.colorscheme 'kanso'
  end,
}
