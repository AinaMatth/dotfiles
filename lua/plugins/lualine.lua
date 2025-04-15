return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  opts = {
    theme = 'tokyonight',
    globalstatus = vim.o.laststatus == 3,
    options = { disabled_filetypes = { statusline = { 'snacks_dashboard' } } },
  },
}
