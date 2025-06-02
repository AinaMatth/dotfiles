---@type vim.lsp.Config
local on_attach = function(client, bufnr)
  if client.name == 'ruff_lsp' then
    client.server_capabilities.hoverProvider = false
  end
end
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  settings = {
    args = {},
  },
  on_attach = on_attach,
}
