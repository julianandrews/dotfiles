" Clear trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
" Run document formatting
autocmd BufWritePre * LspDocumentFormatSync
