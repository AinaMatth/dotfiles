-- Mason ================================================================
require("mason").setup({
  ui = {
      icons = {
        package_pending = ' ',
        package_installed = ' ',
        package_uninstalled = ' ',
      },
    },
  }
)
-- Diagnostics ========================================================
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

require("lazydev").setup({
        library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      }
})

vim.lsp.config.lua_ls = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  single_file_support = true,
  log_level = 2,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}
vim.lsp.enable 'lua_ls'
