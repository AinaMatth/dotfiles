return {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  cmd = { 'ConformInfo', 'ConformFormat', 'ConformFormat', 'ConformToggleFormatGlobal' },
  event = 'BufWritePre',
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      -- sql = { 'sqruff', stop_after_first = true },
      -- rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      c = { 'clang-format' },
      -- quarto = { 'injected' },
      -- rmd = { 'injected' },
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
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
