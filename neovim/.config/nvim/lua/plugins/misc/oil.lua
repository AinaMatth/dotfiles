return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  lazy = false,
  config = function()
    local detail = false
    require('oil').setup {
      keymaps = {
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            detail = not detail
            if detail then
              require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require('oil').set_columns { 'icon' }
            end
          end,
        },
      },
    }
    vim.keymap.set('n', '-', '<cmd>Oil --float<cr>', { desc = 'Open Oil' })
  end,
}
