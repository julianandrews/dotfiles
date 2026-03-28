vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_markers = { '.git', 'CMakeLists.txt', 'compile_commands.json', '.clangd' },
  settings = {
    clangd = {
      clangdFileStatus = true,
      useLibraryCodeForTypes = true,
      InlayHints = {
        enabled = true,
      },
    },
  },
})

vim.lsp.enable('clangd')
