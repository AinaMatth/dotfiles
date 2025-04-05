require("mason").setup({})
-- Setup language servers.

vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  single_file_support = true,
  log_level = 2,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}
vim.lsp.enable("lua_ls")

vim.lsp.config.ruff = {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  single_file_support = true,
  settings = {},
}
vim.lsp.enable("ruff")

vim.lsp.config.basedpyright = {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  single_file_support = true,
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
}
vim.lsp.enable("basedpyright")

vim.lsp.config.rust_analyzer = {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  single_file_support = true,
  settings = {},
}
vim.lsp.enable("rust_analyzer")
