return {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
  settings = {
    capabilities = {
      offsetEncoding = { 'utf-8', 'utf-16' },
      textDocument = {
        completion = {
          editsNearCursor = true,
        },
      },
    },
  },
}
