vim.lsp.config('rust_analyzer', {
  cmd = { '/usr/bin/rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', '.git' },
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = "clippy",
      },
    },
  },
})

vim.lsp.enable('rust_analyzer')

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.rs' },
  callback = function(args)
    vim.lsp.buf.format({ async = false })
  end,
})
