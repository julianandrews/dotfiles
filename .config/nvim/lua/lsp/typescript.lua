vim.lsp.config('vtsls', {
  cmd = { 'vtsls', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact', 'javascript.jsx' },
  root_markers = { 'package.json', 'tsconfig.json', '.git' },
  settings = {
    vtsls = {
      complete = {
        includeCompletionsForModuleAugmentation = true,
        includeCompletionsForImportStatements = true,
      },
      goToSourceDefinition = true,
    },
  },
})

vim.lsp.enable('vtsls')

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
  callback = function(args)
    vim.lsp.buf.format({ async = false })
  end,
})
