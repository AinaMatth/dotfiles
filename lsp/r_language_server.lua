return {
  cmd = { 'R', '--no-echo', '-e', 'languageserver::run()' },
  filetypes = { 'r', 'rmd', 'quarto' },
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
