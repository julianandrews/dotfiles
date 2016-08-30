" Clear trailing whitespace in selected file types on save
autocmd BufWritePre *.py,*.js,*.hs,*.html,*.css,*.scss :%s/\s\+$//e

" Use htmldjango by default for html files
autocmd BufNewFile,BufRead *.html set filetype=htmldjango
