return {
  'williamboman/mason.nvim',
  cmd = { 'Mason', 'MasonInstall', 'MasonUpdate' },
  keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
  build = ':MasonUpdate',
  opts = {
    ui = {
      icons = {
        package_pending = ' ',
        package_installed = ' ',
        package_uninstalled = ' ',
      },
    },
  },
}
