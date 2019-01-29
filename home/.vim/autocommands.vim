" Clear trailing whitespace in selected file types on save
autocmd BufWritePre * :%s/\s\+$//e

" Format changed
augroup FormatChanged
    autocmd FileType c,cpp
        \ autocmd! FormatChanged BufWritePre <buffer> call FormatChangedLines()
augroup END
