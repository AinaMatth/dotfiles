return {
  'williamboman/mason.nvim',
  opts = {
    ui = {
      icons = {
        package_pending = ' ',
        package_installed = ' ',
        package_uninstalled = ' ',
      },
    },
    max_concurrent_installers = 10,
  },
}
