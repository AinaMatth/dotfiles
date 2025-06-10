local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later
local ensure_installed = {
  'bash',
  'c',
  'cpp',
  'csv',
  'diff',
  'html',
  'javascript',
  'jsdoc',
  'json',
  'jsonc',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'printf',
  'python',
  'query',
  'regex',
  'r',
  'rnoweb',
  'css',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
}
now_if_args(function()
  add {
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'main',
    hooks = {
      post_checkout = function()
        vim.cmd 'TSUpdate'
        require('nvim-treesitter').setup {
          install_dirs = vim.fn.stdpath 'data' .. '/treesitter-parsers',
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          indent = { enable = true },
        }
        vim.defer_fn(function()
          local alreadyInstalled = require('nvim-treesitter').get_installed()
          local parsersToInstall = vim
            .iter(ensure_installed)
            :filter(function(parser)
              return not vim.tbl_contains(alreadyInstalled, parser)
            end)
            :totable()
          require('nvim-treesitter').install(parsersToInstall)
        end, 1000)
      end,
    },
  }
  add {
    source = 'nvim-treesitter/nvim-treesitter-textobjects',
    checkout = 'main',
  }
end)

-- Mason
later(function()
  add 'mason-org/mason.nvim'
  require('mason').setup {
    ui = {
      icons = {
        package_pending = ' ',
        package_installed = ' ',
        package_uninstalled = ' ',
      },
    },
    max_concurrent_installers = 10,
  }
end)
later(function()
  add 'stevearc/conform.nvim'
  require('conform').setup {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      c = { 'clang-format' },
      quarto = { 'injected' },
      sh = { 'shfmt' },
      markdown = { 'injected' },
      r = { 'air' },
    },
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = 'fallback',
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  }
  require('conform').formatters.injected = {
    options = {
      ignore_errors = false,
      lang_to_ext = {
        bash = 'sh',
        c_sharp = 'cs',
        elixir = 'exs',
        javascript = 'js',
        julia = 'jl',
        latex = 'tex',
        markdown = 'md',
        python = 'py',
        ruby = 'rb',
        rust = 'rs',
        teal = 'tl',
        r = 'r',
        typescript = 'ts',
      },
      lang_to_formatters = {},
    },
  }
end)

later(function()
  vim.diagnostic.config {
    severit_sort = true,
    virtual_lines = { current_line = true },
    float = { border = 'rounded' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '󰌵',
      },
    },
  }
  vim.lsp.enable {
    'lua_ls',
    'air',
    'r_language_server',
    'clangd',
    'ruff',
    'rust_analyzer',
    'vtsls',
  }
end)
later(function()
  add 'rafamadriz/friendly-snippets'
  add 'folke/lazydev.nvim'
  require('lazydev').setup {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      { path = 'mini.nvim', words = { 'Mini' } },
    },
  }
end)
later(function()
  add 'jpalardy/vim-slime'
  vim.g.slime_target = 'tmux'
  vim.g.slime_default_config = {
    socket_name = 'default',
    target_pane = '{last}',
  }

  vim.g.slime_bracketed_paste = 1
  vim.api.nvim_set_var('slime_no_mappings', 1)
  vim.g.slime_cell_delimiter = '```'
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  map('n', '<leader>cl', '<Plug>SlimeLineSend', opts)
  map('v', '<leader>cs', '<Plug>SlimeRegionSend', opts)
  map('n', '<leader>rl', '<cmd>SlimeSend1 ls()<CR>', opts)
  map('n', '<leader>rq', '<cmd>SlimeSend1 q()<CR>', opts)
  map('n', '<leader>rr', '<cmd>SlimeSend1 rm(list = ls())<CR>', opts)
end)
later(function()
  add { source = 'zbirenbaum/copilot.lua' }
  ---@diagnostic disable-next-line: undefined-field
  require('copilot').setup {
    suggestion = {
      auto_trigger = true,
      hide_during_completion = false,
    },
    filetypes = {
      markdown = true,
      gitcommit = true,
      ['*'] = function()
        -- disable for files with specific names
        local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
        local disable_patterns = { 'env', 'conf', 'local', 'private' }
        return vim.iter(disable_patterns):all(function(pattern)
          return not string.match(fname, pattern)
        end)
      end,
    },
  }
  local hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
  vim.api.nvim_set_hl(0, 'CopilotSuggestion', vim.tbl_extend('force', hl, { underline = true }))
end)
later(function()
  add {
    source = 'olimorris/codecompanion.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  }
  require('codecompanion').setup {}
  vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle CodeCompanionChat' })
  vim.keymap.set('n', '<leader>ca', '<cmd>CodeCompanionActions<cr>', { desc = 'CodeCompanion Actions' })
end)
later(function()
  add 'ibhagwan/fzf-lua'
  require('fzf-lua').setup {
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
  }
end)
