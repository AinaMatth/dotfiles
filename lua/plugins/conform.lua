return {
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo', 'ConformFormat', 'ConformFormat', 'ConformToggleFormatGlobal' },
  event = 'BufWritePre',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black', stop_after_first = true },
      -- rust = { "rustfmt", lsp_format = "fallback" },
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  },
}
