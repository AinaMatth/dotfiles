return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        prompt_prefix = '  ',
        selection_caret = ' ',
        entry_prefix = ' ',
        borderchars = {
          prompt = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
          results = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
          preview = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        },
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        file_ignore_patterns = {
          'node_modules/',
          '.git/',
          'dist/',
          'build/',
          '%.lock',
          '%.cache',
          '%.class',
          '%.o',
          '%.pyc',
          '%.exe',
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
          '--glob',
          '!.git/*',
        },
        path_display = { 'smart' },
        dynamic_preview_title = true,
        color_devicons = true,
        scroll_strategy = 'cycle',
        mappings = {
          n = { ['q'] = require('telescope.actions').close },
          i = { ['<Esc>'] = require('telescope.actions').close },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      },
    }
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope [H]elp' })
    vim.keymap.set('n', '<leader>sf', function()
      builtin.find_files { hidden = true, no_ignore = true }
    end, { desc = 'Telescope [F]iles (cwd)' })
    vim.keymap.set('n', '<leader>sF', function()
      builtin.find_files { cwd = vim.loop.os_homedir(), hidden = true, no_ignore = true }
    end, { desc = 'Telescope [F]iles (root)' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Telescope [S]elect' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Telescope [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Telescope [R]esume' })
    vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = 'Telescope Recent Files' })
    vim.keymap.set('n', '<leader><leader>', function()
      builtin.buffers {
        sort_lastused = true,
        sort_mru = true,
        ignore_current_buffer = true,
      }
    end, { desc = '[ ] Telescope buffers' })
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = 'Telescope [/] in Open Files' })
    vim.keymap.set('n', '<leader>sc', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Telescope [N]eovim files' })
  end,
}
