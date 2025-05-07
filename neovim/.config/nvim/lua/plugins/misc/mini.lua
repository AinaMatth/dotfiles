return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    require('mini.statusline').setup()
    require('mini.indentscope').setup()
    require('mini.icons').setup {}
    require('mini.pairs').setup {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { 'string' },
      skip_unbalanced = true,
      markdown = true,
    }
    require('mini.files').setup {
      options = {
        use_as_default_explorer = true,
      },
      windows = {
        preview = true,
        width_focus = 40,
        width_nofocus = 20,
        border = 'rounded',
      },
      mappings = {
        show_help = '?',
        go_in_plus = '<cr>',
        go_out_plus = '<tab>',
      },
    }
    vim.keymap.set('n', '<leader>e', function()
      require('mini.files').open()
    end, { desc = 'Open Mini Files' })
  end,
}
