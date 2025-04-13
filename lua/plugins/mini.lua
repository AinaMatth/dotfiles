return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    local statusline = require 'plugins.mini.statusline'
    local clue = require 'plugins.mini.clue'
    local pick = require 'plugins.mini.pick'
    require('mini.statusline').setup(statusline.config)
    require('mini.clue').setup(clue.config)
    require('mini.icons').setup {}
    require('mini.pick').setup(pick.config)
    vim.ui.select = MiniPick.ui_select
    require('mini.extra').setup()
    require 'mini.misc'
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

    -- Highlight patterns in text
    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }

    -- Miscellaneous useful functions
    require('mini.misc').setup()

    -- Move any selection in any direction
    require('mini.move').setup()

    -- Show notifications
    require('mini.notify').setup()

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

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
