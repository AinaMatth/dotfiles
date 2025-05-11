return {
  {
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
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      display = {
        chat = {
          auto_scroll = false,
        },
      },
      strategies = {
        chat = {
          roles = {
            llm = function(adapter)
              return '  CodeCompanion (' .. adapter.formatted_name .. ')'
            end,
            user = '  Me',
          },
        },
      },
    },
    keys = {
      {
        '<Space>cf',
        ':CodeCompanion<CR>',
        mode = { 'n', 'v' },
        silent = true,
        desc = 'CodeCompanion',
      },
      {
        '<Space>cc',
        ':CodeCompanionChat<CR>',
        mode = { 'n', 'v' },
        silent = true,
        desc = 'CodeCompanion Chat',
      },
      {
        '<Space>ca',
        ':CodeCompanionAction<CR>',
        mode = { 'n', 'v' },
        silent = true,
        desc = 'CodeCompanion Action',
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    ft = { 'markdown', 'markdown.mdx', 'Avante', 'codecompanion', 'quarto' },
    opts = {
      file_types = { 'markdown', 'Avante', 'codecompanion' },
      completions = { blink = { enabled = true } },
    },
  },
}
