local ensure_installed = {
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
}
return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    branch = 'main',
    cmd = {
      'TSUpdateSync',
      'TSInstall',
      'TSUpdate',
    },
    build = ':TSUpdate',
    opts = {
      install_dirs = vim.fn.stdpath 'data' .. '/treesitter-parsers',
    },
    config = function(_, opts)
      require('nvim-treesitter').setup(opts)
      -- auto-install parsers
      vim.defer_fn(function()
        local alreadyInstalled = require('nvim-treesitter.config').get_installed()
        local parsersToInstall = vim
          .iter(ensure_installed)
          :filter(function(parser)
            return not vim.tbl_contains(alreadyInstalled, parser)
          end)
          :totable()
        require('nvim-treesitter').install(parsersToInstall)
      end, 1000)
    end,
  },
}
