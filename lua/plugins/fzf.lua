return {
  'ibhagwan/fzf-lua',
  dependencies = { 'echasnovski/mini.icons' },
  opts = {
    winopts = {
      height = 0.85,
      width = 0.80,
      row = 0.35,
      border = false,
      preview = {
        border = false,
        wrap = 'nowrap',
        hidden = 'nohidden',
        vertical = 'down:55%',
        layout = 'flex',
        title = true,
      },
    },

    fzf_colors = {
      ['fg'] = { 'fg', 'Normal' },
      ['bg'] = { 'bg', 'Normal' },
      ['hl'] = { 'fg', 'Special' },
      ['fg+'] = { 'fg', 'CursorLine' },
      ['bg+'] = { 'bg', 'CursorLine' },
      ['hl+'] = { 'fg', '@Keyword' },
      ['info'] = { 'fg', '@Parameter' },
      ['border'] = { 'bg', 'Normal' },
      ['prompt'] = { 'fg', '@Function' },
      ['pointer'] = { 'fg', '@Type' },
      ['marker'] = { 'fg', '@Constant' },
      ['spinner'] = { 'fg', '@Variable' },
      ['header'] = { 'fg', 'Comment' },
      ['gutter'] = { 'bg', 'Normal' },
    },

    -- FZF command options for a clean look
    fzf_opts = {
      ['--no-scrollbar'] = true,
      ['--layout'] = 'reverse',
      ['--pointer'] = '→',
      ['--marker'] = '●',
      ['--info'] = 'inline-right',
      ['--ansi'] = true,
      ['--tabstop'] = 2,
    },

    -- File display and icon settings
    file_icon_padding = ' ',
    file_icon_colors = true,

    -- Search type customizations
    files = {
      prompt = ' Files: ',
      git_icons = true,
      file_icons = true,
      color_icons = true,
    },

    grep = {
      prompt = ' Grep: ',
      git_icons = true,
      file_icons = true,
      color_icons = true,
      rg_opts =
      "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g '!{node_modules,.git}'",
    },
  },
  keys = {
    {
      '<leader>ff',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Find files (Root)',
    },
    {
      '<leader>fc',
      function()
        require('fzf-lua').files { cwd = '~/.config/nvim/' }
      end,
      desc = 'Find Config files',
    },
    {
      '<leader>fb',
      function()
        require('fzf-lua').buffers()
      end,
      desc = 'Find buffers',
    },
    {
      '<leader>fo',
      function()
        require('fzf-lua').oldfiles()
      end,
      desc = 'Find recent files',
    },
    {
      '<leader>fl',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = 'Live grep',
    },
    {
      '<leader>fw',
      function()
        require('fzf-lua').grep_cword()
      end,
      desc = 'Find word under cursor',
    },
    -- LSP related
    {
      '<leader>fs',
      function()
        require('fzf-lua').lsp_document_symbols()
      end,
      desc = 'Find document symbols',
    },
    {
      '<leader>fr',
      function()
        require('fzf-lua').lsp_references()
      end,
      desc = 'Find references',
    },
    {
      '<leader>fd',
      function()
        require('fzf-lua').files { cwd = vim.fn.expand '%:p:h' }
      end,
      desc = 'Find files in current directory',
    },

    -- Miscellaneous
    {
      '<leader>fh',
      function()
        require('fzf-lua').help_tags()
      end,
      desc = 'Find help tags',
    },
    {
      '<leader>fk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = 'Find keymaps',
    },
  },
}
