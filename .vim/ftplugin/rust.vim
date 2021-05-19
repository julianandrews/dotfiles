compiler cargo

if has('nvim')
    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
endif
