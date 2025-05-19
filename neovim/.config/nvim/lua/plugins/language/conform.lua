return {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  cmd = { 'ConformInfo', 'ConformFormat', 'ConformFormat', 'ConformToggleFormatGlobal' },
  event = 'BufWritePre',
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        -- sql = { 'sqruff', stop_after_first = true },
        -- rust = { "rustfmt", lsp_format = "fallback" },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        c = { 'clang-format' },
        quarto = { 'injected' },
        rmd = { 'injected' },
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
          markdown = 'md',
          python = 'py',
          r = 'r',
        },
        lang_to_formatters = {},
      },
    }
  end,
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
