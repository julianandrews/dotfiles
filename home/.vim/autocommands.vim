" Clear trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Use htmldjango by default for html files
autocmd BufNewFile,BufRead *.html set filetype=htmldjango
