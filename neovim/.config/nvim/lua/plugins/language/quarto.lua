return {
  'quarto-dev/quarto-nvim',
  ft = { 'quarto' },
  dependencies = {
    {
      'jmbuhr/otter.nvim',
      dependencies = { 'neovim/nvim-lspconfig', 'nvim-treesitter/nvim-treesitter' },
      config = function()
        local otter = require 'otter'
        otter.setup {
          buffers = {
            write_to_disk = true,
          },
        }
      end,
    },
  },
  opts = {
    lspFeatures = {
      languages = { 'r', 'python', 'julia', 'bash', 'lua', 'html' },
      chunks = 'curly',
      diagnostics = {
        enabled = true,
        trigger = 'BufWritePost',
      },
      completion = {
        enabled = true,
      },
    },
    codeRunner = {
      enabled = true,
      default_method = 'slime',
    },
  },
  config = function(_, opts)
    require('quarto').setup(opts)
    local runner = require 'quarto.runner'
    vim.keymap.set('n', '<localleader>qc', runner.run_cell, { desc = 'run cell' })
    vim.keymap.set('n', '<localleader>qa', runner.run_above, { desc = 'run cell and above' })
    vim.keymap.set('n', '<localleader>qA', runner.run_all, { desc = 'run all cells' })
    vim.keymap.set('n', '<localleader>ql', runner.run_line, { desc = 'run line' })
    vim.keymap.set('v', '<localleader>qr', runner.run_range, { desc = 'run visual range' })
  end,
}
