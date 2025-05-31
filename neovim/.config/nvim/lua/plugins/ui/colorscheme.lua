return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      styles = {
        comments = {},
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
    }
    vim.cmd 'colorscheme catppuccin'
  end,
}
