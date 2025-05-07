return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      styles = {
        comments = {},
      },
      compile_path = vim.fn.stdpath 'cache' .. '/catppuccin',
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        treesitter = true,
        render_markdown = true,
        mini = {
          enabled = true,
          indent_scope_color = 'lavender',
        },
        which_key = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
