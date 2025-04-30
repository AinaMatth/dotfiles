return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
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
  build = ':TSUpdate',
  config = function()
    local configs = require 'nvim-treesitter.configs'

    configs.setup {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'csv',
        'diff',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'printf',
        'python',
        'query',
        'regex',
        'r',
        'rnoweb',
        'css',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      },
      sync_install = false,
      highlight = {
        enable = true,
        use_languagetree = true,
        indent = { enable = true },
        highlight = { enable = true },
        incremental_selection = { enable = true },
        additional_vim_regex_highlighting = false,

        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
    }
  end,
}
