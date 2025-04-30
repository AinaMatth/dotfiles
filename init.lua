vim.loader.enable()
require 'core.options'
require 'core.keymaps'
require 'core.autocmds'
require 'core.lazy'
require 'core.statusline'
require('core.runner').setup {}
vim.lsp.enable {
  'sqlls',
  'html',
  'ruff',
  'ts_ls',
  'pylsp',
  'lua_ls',
  'clangd',
  'rust_analyzer',
  'air',
  'r_language_server',
}
