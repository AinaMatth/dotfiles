return {
  'echasnovski/mini.clue',
  event = 'VeryLazy',
  config = function()
    local miniclue = require 'mini.clue'
    miniclue.setup {
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
      },

      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        { mode = 'n', keys = '<leader>s', desc = '+fzf' },
        { mode = 'x', keys = '<leader>s', desc = '+fzf' },
        { mode = 'n', keys = '<leader>g', desc = '+git' },
        { mode = 'x', keys = '<leader>g', desc = '+git' },
        { mode = 'n', keys = '<leader>x', desc = '+trouble' },
        { mode = 'x', keys = '<leader>x', desc = '+trouble' },
        { mode = 'n', keys = '<leader>r', desc = '+r' },
        { mode = 'x', keys = '<leader>r', desc = '+r' },
        { mode = 'n', keys = '<leader>c', desc = '+code' },
        { mode = 'x', keys = '<leader>c', desc = '+code' },
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
      window = {
        delay = 0,
        config = function(bufnr)
          local max_width = 0

          for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
            max_width = math.max(max_width, vim.fn.strchars(line))
          end

          -- Keep some right padding.
          max_width = max_width + 2

          return {
            -- Dynamic width capped at 70.
            width = math.min(70, max_width),
          }
        end,
      },
    }
  end,
}
