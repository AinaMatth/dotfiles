-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup {
  spec = {
    { import = 'plugins.ui' },
    { import = 'plugins.editor' },
    { import = 'plugins.language' },
    { import = 'plugins.completion' },
    { import = 'plugins.misc' },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    missing = true,
    colorscheme = { 'default' },
  },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  rocks = {
    enabled = false,
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
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
    border = 'rounded',
    title = '󰒲 Lazy',
    icons = {
      cmd = '  ', ---+ ${ui, Lazy.nvim UI icons}

      config = '  ',
      event = '  ',
      ft = '  ',

      init = '  ',
      imports = '  ',

      keys = '  ',

      lazy = ' ',
      loaded = ' ',
      not_loaded = ' ',

      plugin = '  ',
      runtime = '  ',
      require = '  ',

      source = ' ',
      start = '',

      task = '  ', ---_
    },
  },
}
