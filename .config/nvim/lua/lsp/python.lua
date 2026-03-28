vim.lsp.config('basedpyright', {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { '.git', 'pyproject.toml', 'setup.py', 'requirements.txt', '.venv' },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'workspace',
        useLibraryCodeForTypes = true,
      },
    },
  },
})

vim.lsp.enable('basedpyright')

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.py' },
  callback = function(args)
    vim.lsp.buf.format({ async = false, formatters = { 'ruff' } })
  end,
})
