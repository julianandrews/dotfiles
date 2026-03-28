vim.lsp.config('bash_language_server', {
  cmd = { 'bash-language-server', '--stdio' },
  filetypes = { 'bash', 'sh', 'zsh' },
  root_markers = { '.git', '.bashrc', '.zshrc' },
})

vim.lsp.enable('bash_language_server')
