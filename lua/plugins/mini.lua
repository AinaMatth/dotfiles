return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    local statusline = require 'plugins.mini.statusline'
    require('mini.statusline').setup(statusline.config)
    local clue = require 'plugins.mini.clue'
    require('mini.clue').setup(clue.config)
    require('mini.icons').setup {}
    vim.api.nvim_create_user_command('MiniFiles', function()
      require('mini.files').setup {
        windows = {
          preview = true,
          width_focus = 30,
          width_preview = 30,
        },
        options = {
          use_as_default_explorer = true,
        },
      }
      MiniFiles.open()
    end, {})

    -- Keymaps
    vim.keymap.set('n', '-', '<cmd>MiniFiles<CR>', { desc = 'Open mini.files (Directory of Current File)' })
    -- Delay load non-essential modules
    vim.defer_fn(function()
      require('mini.indentscope').setup {}
      require('mini.notify').setup {}
      require('mini.diff').setup {
        view = {
          style = 'sign',
          signs = {
            add = '▎',
            change = '▎',
            delete = '',
          },
        },
      }
      require('mini.git').setup {}
    end, 100) -- 100ms delay after startup

    -- Load pairs on insert enter
    vim.api.nvim_create_autocmd('InsertEnter', {
      once = true,
      callback = function()
        require('mini.pairs').setup {
          modes = { insert = true, command = true, terminal = false },
          skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
          skip_ts = { 'string' },
          skip_unbalanced = true,
          markdown = true,
        }
      end,
    })
  end,
}
