return {
  'folke/snacks.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
    config = function()
      require('todo-comments').setup {}
    end,
  },
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
      ⠀⠀⠀⠀⠀⠀⣰⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⣰⠟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀
      ⠀⠀⠀⠀⢀⠁⠀⠇⠀⠀⠀⠀⠀⠀⠀⢀⠀⠤⠀⠒⣶⣶⠆⠀⠀⢀⠔⠁⢠⠀
      ⠀⠀⠀⠀⠘⢀⠼ ⠤ ⠤ ⡠⠐⠈⠀⠀⠀⠀⡰⠟⠁⠀⢀⠔⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⢜⡁⠀⠀⠀⣖⣦⠀⠀⠤⣤⠄⠐⠂⠁⠀⠀⢀⠔⠁⠀⠀⠀⠀⠀⡇
      ⠀⠀⠀⡸⠷⢁⡀⢀⡀⠈⢉⠤⢄⠀⠈⡀⠀⠀⠀⠀⣔⡁⠄⠄⠀⠀⢀⠠⠂⠁
      ⠀⠀⢠⢻⠀⠹⣿⠿⡇⠀⠡⠔⠜⠀⠀⢁⠀⠀⠀⠀⢡⠀⠀⢀⠄⠊⠁⠀⠀⠀
      ⠀⠀⠀⠫⡀⠀⠐⠤⠃⠀⠀⠀⠀⢀⠀⠀⢂⠀⠀⠀⠀⢃⠀⠸⠀⠀⠀⠀⠀⠀
      ⢀⠠⠐⠂⠉⠢⠀⡀⠀⠀⠀⠀⠖⠉⠉⠀⠀⢧⡀⠀⡠⠒⠀⡠⠀⠀⠀⠀⠀⠀
      ⢸⡘⠀⠀⠀⠀⢢⠈⠂⠀⠀⠀⠘⢤⣄⣤⠄⠀⠈⢊⠢⣠⣎⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠉⠀⠒⠒⠀⢣⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠗⣾⠿⠆⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡷⠄⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠘⡀⠀⠀⠀⣀⣀⠀⠀⢀⣀⡀⠤⢊⠆⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠐⠢⢤⣥⠒⠉⠉⠑⠂⠠⠤⡤⢺⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢛⠀⠀⠀⠀⠀⠀⠀⠐⢾⠀⠀⠀⠀⠀⠀⠀⠀⠀

           ]],
      },
      sections = {
        {
          section = 'header',
          height = 17,
          padding = 2,
        },
        {
          pane = 2,
          { section = 'keys', gap = 1, padding = 1 },
          { section = 'startup' },
        },
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
    },
    picker = {
      enabled = true,
      prompt = ' ',
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = {
      win = {
        position = 'float',
        border = 'rounded',
        title = '   Terminal',
        title_pos = 'center',
      },
    },
    words = { enabled = true },
    zen = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
  keys = {
    -- Top Pickers & Explorer
    {
      '<leader><space>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>e',
      function()
        Snacks.explorer()
      end,
      desc = 'File Explorer',
    },
    -- find
    {
      '<leader>fc',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Find Config File',
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>fg',
      function()
        Snacks.picker.git_files()
      end,
      desc = 'Find Git Files',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Find Recent',
    },
    {
      '<leader>fp',
      function()
        Snacks.picker.pickers()
      end,
      desc = 'Find Pickers',
    },
    {
      '<leader>fP',
      function()
        Snacks.picker.projects()
      end,
      desc = 'Projects',
    },
    -- git
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git Status',
    },
    -- Grep
    {
      '<leader>fB',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>fh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>fk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>fu',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undo History',
    },
    {
      '<leader>fs',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>fS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'LSP Workspace Symbols',
    },
    -- Other
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>m',
      function()
        Snacks.scratch { ft = 'markdown', icon = '' }
      end,
      desc = 'Toggle Scratch [MD] Buffer',
    },

    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    {
      '<leader>n',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },
    {
      '<leader>cR',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Rename File',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<c-_>',
      function()
        Snacks.terminal(nil, opts)
      end,
      desc = 'Toggle Float Terminal',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle
          .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map '<leader>uc'
        Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        Snacks.toggle.inlay_hints():map '<leader>uh'
        Snacks.toggle.indent():map '<leader>ug'
        Snacks.toggle.dim():map '<leader>uD'
      end,
    })
  end,
}
