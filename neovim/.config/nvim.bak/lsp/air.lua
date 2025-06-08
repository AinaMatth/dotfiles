---@type vim.lsp.Config
return {
  cmd = { 'air', 'language-server' },
  filetypes = { 'r' },
  root_markers = { 'air.toml', '.air.toml', '.git' },
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end,
}
