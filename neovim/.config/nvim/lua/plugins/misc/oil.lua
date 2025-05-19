return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  lazy = false,
  config = function(_, opts)
    require('oil').setup(opts)
    vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open Oil' })
  end,
}
