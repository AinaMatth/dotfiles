local M = {}

M.config = {
  window = {
    delay = 300,
    config = { width = 'auto', border = 'single' },
  },
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>', desc = 'Leader key' },
    { mode = 'x', keys = '<Leader>', desc = 'Leader key (visual mode)' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>',    desc = 'Built-in completion' },

    -- `g` key
    { mode = 'n', keys = 'g',        desc = 'g commands' },
    { mode = 'x', keys = 'g',        desc = 'g commands (visual mode)' },

    -- Marks
    { mode = 'n', keys = "'",        desc = 'Marks' },
    { mode = 'n', keys = '`',        desc = 'Marks' },
    { mode = 'x', keys = "'",        desc = 'Marks (visual mode)' },
    { mode = 'x', keys = '`',        desc = 'Marks (visual mode)' },

    -- Registers
    { mode = 'n', keys = '"',        desc = 'Registers' },
    { mode = 'x', keys = '"',        desc = 'Registers (visual mode)' },
    { mode = 'i', keys = '<C-r>',    desc = 'Registers (insert mode)' },
    { mode = 'c', keys = '<C-r>',    desc = 'Registers (command mode)' },

    -- Window commands
    { mode = 'n', keys = '<C-w>',    desc = 'Window commands' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },
  clues = {
    require('mini.clue').gen_clues.builtin_completion(),
    require('mini.clue').gen_clues.g(),
    require('mini.clue').gen_clues.marks(),
    require('mini.clue').gen_clues.registers(),
    require('mini.clue').gen_clues.windows(),
    require('mini.clue').gen_clues.z(),
    require('mini.clue').gen_clues.z(),
    { mode = 'n', keys = '<Leader>s', desc = '[S]earch' },
  },
}

return M
