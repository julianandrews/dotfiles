" Clear trailing whitespace in selected file types on save
autocmd BufWritePre * :%s/\s\+$//e
