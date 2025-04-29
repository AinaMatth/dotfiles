return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      styles = {
        comments = {},
      },
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        treesitter = true,
        snacks = true,
        lsp_trouble = true,
        which_key = true,
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
