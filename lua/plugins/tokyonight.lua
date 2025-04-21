return {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      transparent = true,
      styles = { comments = { italic = false }, sidebars = 'transparent', floats = 'transparent' },
      lualine_bold = true,
    }
    vim.cmd.colorscheme 'tokyonight'
  end,
}
