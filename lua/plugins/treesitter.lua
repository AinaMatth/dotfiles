return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = {
    'EditQuery',
    'Inspect',
    'InspectTree',
    'TSBufDisable',
    'TSBufEnable',
    'TSDisable',
    'TSEnable',
    'TSInstall',
    'TSModuleInfo',
    'TSUpdate',
    'TSUpdateSync',
  },
  config = function()
    local configs = require 'nvim-treesitter.configs'

    configs.setup {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'regex',
        'python',
        'javascript',
        'typescript',
        'rust',
      },
      auto_install = true,
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
    }
  end,
}
