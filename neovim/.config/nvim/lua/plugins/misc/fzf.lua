return {
  'ibhagwan/fzf-lua',
  dependencies = { 'echasnovski/mini.icons' },
  opts = {
    winopts = {
      height = 0.85,
      width = 0.85,
      row = 0.3,
      col = 0.5,
      border = 'rounded',
      fullscreen = false,
    },
    previewers = {
      bat = {
        theme = 'Coldark-Dark',
      },
    },
    fzf_opts = {
      ['--layout'] = 'reverse',
      ['--info'] = 'inline',
    },
    fzf_colors = true,
    files = {
      prompt = 'Files❯ ',
      fd_opts = '--color=never --type f --hidden --follow --exclude .git --strip-cwd-prefix',
    },
    grep = {
      prompt = 'Grep❯ ',
      rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --trim --glob '!**/.git/*' --glob '!**/node_modules/*'",
    },
  },
  keys = {
    {
      '<leader>ff',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Find Files in project directory',
    },
    {
      '<leader>f/',
      function()
        require('fzf-lua').files { cwd = vim.env.HOME }
      end,
      desc = 'Find Files in home directory',
    },

    {
      '<leader>fg',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = 'Find by grepping in project directory',
    },
    {
      '<leader>fc',
      function()
        require('fzf-lua').files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Find in neovim configuration',
    },
    {
      '<leader>fh',
      function()
        require('fzf-lua').helptags()
      end,
      desc = '[F]ind [H]elp',
    },
    {
      '<leader>fk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = '[F]ind [K]eymaps',
    },
    {
      '<leader>fb',
      function()
        require('fzf-lua').builtin()
      end,
      desc = '[F]ind [B]uiltin FZF',
    },
    {
      '<leader>fw',
      function()
        require('fzf-lua').grep_cword()
      end,
      desc = '[F]ind current [W]ord',
    },
    {
      '<leader>fW',
      function()
        require('fzf-lua').grep_cWORD()
      end,
      desc = '[F]ind current [W]ORD',
    },
    {
      '<leader>fd',
      function()
        require('fzf-lua').diagnostics_document()
      end,
      desc = '[F]ind [D]iagnostics',
    },
    {
      '<leader>fr',
      function()
        require('fzf-lua').resume()
      end,
      desc = '[F]ind [R]esume',
    },
    {
      '<leader>fo',
      function()
        require('fzf-lua').oldfiles()
      end,
      desc = '[F]ind [O]ld Files',
    },
    {
      '<leader><leader>',
      function()
        require('fzf-lua').buffers()
      end,
      desc = '[,] Find existing buffers',
    },
    {
      '<leader>/',
      function()
        require('fzf-lua').lgrep_curbuf()
      end,
      desc = '[/] Live grep the current buffer',
    },
  },
}
