return {
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo', 'ConformFormat', 'ConformFormat', 'ConformToggleFormatGlobal' },
  event = 'BufWritePre',
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff', stop_after_first = true },
      sql = { 'sqruff', stop_after_first = true },
      -- rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      c = { 'clang-format' },
    },
    default_format_opts = {
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
