return {
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { 'string' },
      skip_unbalanced = true,
      markdown = true,
    },
    config = function(_, opts)
      require('mini.pairs').setup(opts)
    end,
  },
  {
    'echasnovski/mini.surround',
    opts = {},
  },
  {
    'echasnovski/mini.hipatterns',
    config = function()
      local hipatterns = require 'mini.hipatterns'
      hipatterns.setup {
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },
  {
    'echasnovski/mini.files',
    version = false,
    keys = {
      {
        '<leader>e',
        function()
          require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = 'File Explorer (MiniFiles)',
      },
    },
    config = function()
      local mf = require 'mini.files'

      mf.setup {
        mappings = {
          close = 'q',
          go_in = 'l',
          go_in_plus = '<CR>',
          go_out = 'h',
          go_out_plus = '<BS>',
          reset = '<C-r>',
          reveal_cwd = '@',
          show_help = 'g?',
          synchronize = '=',
          trim_left = '<',
          trim_right = '>',
        },
        windows = {
          max_number = math.huge,
          preview = true,
          width_focus = 35,
          width_nofocus = 25,
          width_preview = 60,
        },
        options = {
          use_as_default_explorer = true,
        },
      }
    end,
  },
}
