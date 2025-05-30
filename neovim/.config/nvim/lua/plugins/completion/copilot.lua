return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    suggestions = {
      auto_trigger = false,
      debounce = 75,
      ignore_default_suggestions = false,
      use_context = true,
    },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}
