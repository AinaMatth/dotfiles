require 'core.lazy'
require 'core.options'
require 'core.autocmds'
require 'core.lsp'

vim.diagnostic.config {
  virtual_lines = true,
  underline = false,
  float = {
    border = 'single',
    severity_sort = false,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
  },
}
