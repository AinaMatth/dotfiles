return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    suggestions = {
      auto_trigger = true,
      debounce = 75,
      ignore_default_suggestions = false,
      use_context = true,
    },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}
