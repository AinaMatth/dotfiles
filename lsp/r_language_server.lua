return {
  cmd = { 'R', '--no-echo', '-e', 'languageserver::run()' },
  filetypes = { 'r', 'rmd', 'quarto' },
  root_markers = { 'air.toml', '.air.toml', '.git' },
  settings = {},
}
