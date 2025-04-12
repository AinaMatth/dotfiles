return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.icons').setup {}
    require('mini.statusline').setup {
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
          local git = MiniStatusline.section_git { trunc_width = 40 }
          local diff = MiniStatusline.section_diff { trunc_width = 75 }
          local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
          local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
          local filename = MiniStatusline.section_filename { trunc_width = 140 }
          local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
          local position = string.format('Line %d:%d', vim.fn.line '.', vim.fn.col '.')
          return MiniStatusline.combine_groups {
            { hl = mode_hl,                  strings = { mode } },
            { hl = 'MiniStatuslineDevinfo',  strings = { git, diff } },
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%<', -- Mark truncate point
            '%=', -- End left alignment
            { hl = 'MiniStatuslineDevinfo',  strings = { diagnostics, lsp } },
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl,                  strings = { position } },
          }
        end,

        -- Keep inactive windows simple as in NvChad
        inactive = function()
          local filename = MiniStatusline.section_filename { trunc_width = 140 }
          return MiniStatusline.combine_groups {
            { hl = 'MiniStatuslineInactive', strings = { filename } },
          }
        end,
      },
      use_icons = true,
      set_vim_settings = true,
    }
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
      require('mini.diff').setup { view = { style = 'sign' } }
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
