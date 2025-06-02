return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      styles = {
        comments = {},
      },
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        flash = true,
        fzf = true,
        gitsigns = true,
        illuminate = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        noice = true,
        notify = true,
        render_markdown = true,
        semantic_tokens = true,
        treesitter = true,
        which_key = true,
      },
    }
    custom_highlights = function(colors)
      return {
        NormalFloat = { bg = colors.base, fg = colors.text },
      }
    end
    vim.cmd 'colorscheme catppuccin'
  end,
}
