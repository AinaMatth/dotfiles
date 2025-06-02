return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  keys = {
    --stylua:ignore
    { '<leader>sf', '<cmd>FzfLua files<cr>', desc = 'Find Project Files' },
    { '<leader>sc', "<cmd>FzfLua files cwd='~/.dotfiles'<cr>", desc = 'Find Dot Files' },
    { '<leader>sg', '<cmd>FzfLua live_grep_native<cr>', desc = 'Live Grep' },
    { '<leader>sr', '<cmd>FzfLua resume<cr>', desc = 'Resume' },
    { '<leader>sb', '<cmd>FzfLua blines<cr>', desc = 'Buffer lines' },
    { '<leader><leader>', '<cmd>FzfLua buffers<cr>', desc = 'Buffers' },
    { '<leader>/', '<cmd>FzfLua lgrep_curbuf<cr>', desc = 'Grep Buffer' },
    { '<leader>sh', '<cmd>FzfLua help_tags<cr>', desc = 'Help Tags' },
    {
      '<leader>sr',
      function()
        vim.cmd 'rshada!'
        require('fzf-lua').oldfiles()
      end,
      desc = 'Recently opened files',
    },
    { '<leader>sd', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Document Symbols' },
    { '<leader>sw', '<cmd>FzfLua lsp_workspace_symbols<cr>', desc = 'Workspace Symbols' },
    { '<leader>sD', '<cmd>FzfLua diagnostics_documents<cr>', desc = 'Diagnostics' },
  },
  opts = {
    { 'max-perf', 'hide' },
    fzf_colors = {
      bg = { 'bg', 'Normal' },
      gutter = { 'bg', 'Normal' },
      info = { 'fg', 'Conditional' },
      scrollbar = { 'bg', 'Normal' },
      separator = { 'fg', 'Comment' },
    },
    fzf_opts = {
      ['--info'] = 'default',
      ['--layout'] = 'reverse-list',
    },
    winopts = {
      preview = {
        border = 'border-top',
      },
    },
  },
}
