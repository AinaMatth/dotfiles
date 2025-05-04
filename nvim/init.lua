-- ============================================================================
-- Neovim Initialization
-- ============================================================================

-- Enable Lua module caching for improved startup time (requires Neovim 0.9+)
vim.loader.enable()

-- ============================================================================
-- Core Configuration Modules
-- ============================================================================

require 'core.options' -- General settings and vim.opt configuration
require 'core.keymaps' -- Custom key mappings
require 'core.autocmds' -- Autocommands
require 'core.lazy' -- Plugin manager setup (Lazy.nvim)
require 'core.statusline' -- Custom statusline module

-- ============================================================================
-- LSP Configuration
-- ============================================================================

-- Custom abstraction to enable selected language servers
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
