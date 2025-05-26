return {
  'ibhagwan/fzf-lua',
  dependencies = { 'echasnovski/mini.icons' },
  opts = function(_, opts)
    local fzf = require 'fzf-lua'
    local actions = fzf.actions
    local config = fzf.config

    -- Keymaps for preview navigation and power actions
    config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'
    config.defaults.keymap.fzf['ctrl-u'] = 'half-page-up'
    config.defaults.keymap.fzf['ctrl-d'] = 'half-page-down'
    config.defaults.keymap.fzf['ctrl-x'] = 'jump'
    config.defaults.keymap.fzf['ctrl-f'] = 'preview-page-down'
    config.defaults.keymap.fzf['ctrl-b'] = 'preview-page-up'
    config.defaults.keymap.builtin['<c-f>'] = 'preview-page-down'
    config.defaults.keymap.builtin['<c-b>'] = 'preview-page-up'

    -- Root/CWD toggle in file picker
    config.defaults.actions.files['ctrl-r'] = function(_, ctx)
      local o = vim.deepcopy(ctx.__call_opts)
      o.root = o.root == false
      o.cwd = nil
      o.buf = ctx.__CTX.bufnr
      require('lazyvim.util').pick.open(ctx.__INFO.cmd, o)
    end
    config.defaults.actions.files['alt-c'] = config.defaults.actions.files['ctrl-r']

    return {
      fzf_colors = true,
      fzf_opts = {
        ['--no-scrollbar'] = true,
        ['--layout'] = 'reverse',
        ['--info'] = 'inline',
        ['--prompt'] = ' ',
      },
      defaults = {
        formatter = 'path.dirname_first',
      },
      previewers = {
        bat = {
          theme = 'Coldark-Dark',
        },
      },
      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        border = 'rounded',
        preview = { scrollchars = { '┃', '' } },
        title = '  ',
        title_pos = 'center',
      },
      files = {
        prompt = 'Files❯ ',
        fd_opts = '--color=never --type f --hidden --follow --exclude .git --strip-cwd-prefix',
        cwd_prompt = false,
        sort_lastused = true,
        sort_mru = true,
        actions = {
          ['alt-i'] = { actions.toggle_ignore },
          ['alt-h'] = { actions.toggle_hidden },
        },
      },
      grep = {
        prompt = 'Grep❯ ',
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --trim --glob '!**/.git/*' --glob '!**/node_modules/*'",
        actions = {
          ['alt-i'] = { actions.toggle_ignore },
          ['alt-h'] = { actions.toggle_hidden },
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s)
            return 'TroubleIcon' .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. '\t'
          end,
          child_prefix = false,
        },
        code_actions = {
          previewer = vim.fn.executable 'delta' == 1 and 'codeaction_native' or nil,
        },
      },
      ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend('force', fzf_opts, {
          prompt = ' ',
          winopts = {
            title = ' ' .. vim.trim((fzf_opts.prompt or 'Select'):gsub('%s*:%s*$', '')) .. ' ',
            title_pos = 'center',
          },
        }, fzf_opts.kind == 'codeaction' and {
          winopts = {
            layout = 'vertical',
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            preview = not vim.tbl_isempty(require('lazyvim.util').lsp.get_clients { bufnr = 0, name = 'vtsls' }) and {
              layout = 'vertical',
              vertical = 'down:15,border-top',
              hidden = 'hidden',
            } or {
              layout = 'vertical',
              vertical = 'down:15,border-top',
            },
          },
        } or {
          winopts = {
            width = 0.5,
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end,
    }
  end,
  config = function(_, opts)
    require('fzf-lua').setup(opts)
  end,
  init = function()
    -- Use fzf-lua as the backend for vim.ui.select
    vim.ui.select = function(...)
      require('lazy').load { plugins = { 'fzf-lua' } }
      local opts = require('lazyvim.util').opts 'fzf-lua' or {}
      require('fzf-lua').register_ui_select(opts.ui_select or nil)
      return vim.ui.select(...)
    end
  end,
  keys = {
    { '<c-j>', '<c-j>', ft = 'fzf', mode = 't', nowait = true },
    { '<c-k>', '<c-k>', ft = 'fzf', mode = 't', nowait = true },
    -- File/Buffer Navigation
    {
      '<leader>ff',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader><leader>',
      function()
        require('fzf-lua').buffers()
      end,
      desc = 'Switch Buffer',
    },
    {
      '<leader>fb',
      function()
        require('fzf-lua').buffers()
      end,
      desc = 'Buffers',
    },
    -- Project/Config/Dotfiles Navigation
    {
      '<leader>fc',
      function()
        require('fzf-lua').files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Find Config File',
    },
    -- Grep/Search
    {
      '<leader>fg',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = 'Live Grep',
    },
    {
      '<leader>/',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = 'Grep (Root Dir)',
    },
    -- LSP
    {
      '<leader>ss',
      function()
        require('fzf-lua').lsp_document_symbols()
      end,
      desc = 'Goto Symbol',
    },
    {
      '<leader>sS',
      function()
        require('fzf-lua').lsp_live_workspace_symbols()
      end,
      desc = 'Goto Symbol (Workspace)',
    },
    {
      '<leader>fd',
      function()
        require('fzf-lua').diagnostics_document()
      end,
      desc = 'Document Diagnostics',
    },
    -- Quickfix/Location List
    { '<leader>sq', '<cmd>FzfLua quickfix<cr>', desc = 'Quickfix List' },
    { '<leader>sl', '<cmd>FzfLua loclist<cr>', desc = 'Location List' },
    -- Git Integration
    { '<leader>gs', '<cmd>FzfLua git_status<cr>', desc = 'Git Status' },
    { '<leader>gc', '<cmd>FzfLua git_commits<cr>', desc = 'Git Commits' },
    { '<leader>gC', '<cmd>FzfLua git_bcommits<cr>', desc = 'Buffer Commits' },
    -- Command/History/Help Pickers
    { '<leader>:', '<cmd>FzfLua command_history<cr>', desc = 'Command History' },
    {
      '<leader>fh',
      function()
        require('fzf-lua').helptags()
      end,
      desc = 'Find Help',
    },
    {
      '<leader>fk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = 'Find Keymaps',
    },
    -- Other
    {
      '<leader>fo',
      function()
        require('fzf-lua').oldfiles()
      end,
      desc = 'Recent Files',
    },
    { '<leader>fr', '<cmd>FzfLua resume<cr>', desc = 'Resume Last Picker' },
    {
      '<leader>fw',
      function()
        require('fzf-lua').grep_cword()
      end,
      desc = 'Find Current Word',
    },
    {
      '<leader>fW',
      function()
        require('fzf-lua').grep_cWORD()
      end,
      desc = 'Find Current WORD',
    },
  },
}
