return {
  'rebelot/kanagawa.nvim',
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('kanagawa').setup {
      commentStyle = { italic = false },
    }
    vim.cmd.colorscheme 'kanagawa'
  end,
}
