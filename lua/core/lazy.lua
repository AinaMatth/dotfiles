vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { 'kanagawa' } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  },
  performance = {
    -- cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'tutor',
        'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
      },
    },
  },
  ui = {
    icons = {
      ft = '',
      lazy = '󰂠 ',
      loaded = '',
      not_loaded = '',
    },
  },
}
