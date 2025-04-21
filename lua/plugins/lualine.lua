return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'BufReadPre',
  opts = {
    options = {
      theme = 'tokyonight',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      globalstatus = vim.o.laststatus == 3,
      disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
    },
  },
}
