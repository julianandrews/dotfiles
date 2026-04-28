vim.lsp.config('r_language_server', {
  cmd = { "R", "-e", "languageserver::run()", "--args", "--port=3845" },
  filetypes = { "r", "rmd" },
})

vim.lsp.enable('r_language_server')
