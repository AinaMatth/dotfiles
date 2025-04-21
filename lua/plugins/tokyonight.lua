return {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      style = 'storm',
      transparent = true,
      styles = {
        comments = { italic = false },
        sidebars = 'transparent',
        floats = 'transparent',
      },
      on_highlights = function(highlights, colors)
        -- Colors for Snacks pickers
        highlights.SnacksPickerBoxTitle = { bg = '#1c99f2', fg = '#ffffff', bold = true }
      end,
    }
    vim.cmd.colorscheme 'tokyonight'
  end,
}
