return {
  'echasnovski/mini.ai',
  event = 'VeryLazy',
  opts = function()
    local ai = require 'mini.ai'
    return {
      n_lines = 500,
      custom_textobjects = {
        -- Treesitter-powered objects
        o = ai.gen_spec.treesitter {
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        },
        f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
        c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },

        -- Quarto/Rmd code chunks: select entire ```{r} ... ``` blocks
        q = {
          '```{%w+}.-```',
          '^()```{%w+}().-()```()$',
        },

        -- Tag (HTML/XML/Markdown)
        t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
        -- Function calls (general)
        u = ai.gen_spec.function_call(),
        U = ai.gen_spec.function_call { name_pattern = '[%w_]+' },
      },
    }
  end,
  config = function(_, opts)
    require('mini.ai').setup(opts)
  end,
}
