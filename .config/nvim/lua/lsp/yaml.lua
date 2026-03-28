vim.lsp.config('yamlls', {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yml' },
  root_markers = { '.git', '.yamllint', '*.yaml', '*.yml' },
})

vim.lsp.enable('yamlls')
