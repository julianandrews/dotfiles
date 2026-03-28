vim.lsp.config('dockerls', {
  cmd = { 'docker-langserver', '--stdio' },
  filetypes = { 'dockerfile', 'Containerfile' },
  root_markers = { '.git', 'Dockerfile', 'docker-compose.yml', 'docker-compose.yaml' },
  settings = {
    docker = {
      languageserver = {
        formatter = {
          ignoreMultilineInstructions = true,
        },
      },
    },
  },
})

vim.lsp.enable('dockerls')

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { 'Dockerfile', 'Dockerfile.*', 'dockerfile', 'docker-compose.yml', 'docker-compose.yaml' },
  callback = function(args)
    vim.lsp.buf.format({ async = false })
  end,
})
