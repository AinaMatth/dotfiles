return {
  cmd = { 'R', '--no-echo', '-e', 'languageserver::run()' },
  filetypes = { 'r', 'rmd', 'quarto' },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, '.git') or vim.uv.os_homedir())
  end,
  settings = {
    r = {
      lsp = {
        diagnostics = true,
        document_formatting = true,
      },
      editor = {
        tabSize = 2,
        formatOnSave = true,
        formatOnType = false,
      },
    },
  },
}
