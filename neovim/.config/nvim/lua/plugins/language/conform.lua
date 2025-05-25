return {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  cmd = { 'ConformInfo', 'ConformFormat', 'ConformFormat', 'ConformToggleFormatGlobal' },
  event = 'BufWritePre',
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        c = { 'clang-format' },
        quarto = { 'injected' },
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
  end,
}
