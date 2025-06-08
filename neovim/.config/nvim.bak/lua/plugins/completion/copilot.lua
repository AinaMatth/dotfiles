return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  cmd = 'Copilot',
  enabled = false,
  opts = {
    panel = { enabled = false },
    suggestions = {
      auto_trigger = false,
      keymap = {
        next = '<M-]>',
        prev = '<M-[>',
      },
    },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
  keys = {
    {
      '<leader>co',
      function()
        require('copilot.suggestion').toggle_auto_trigger()
      end,
      { desc = 'Toggle Copilot' },
    },
  },
}
