function! StatusFormat(text)
  return a:text != "" ? "[" . a:text . "] " : ""
endfunction

function! FiletypeStatus()
  return StatusFormat(&filetype)
endfunction

" Status Line
set statusline=%<                                           "Truncation Point
set statusline+=%1*%h%r%w%m%*                               "Flags
set statusline+=%f\                                         "File Name
set statusline+=%2*%{FiletypeStatus()}%*                    "File Type
set statusline+=%=                                          "Right Align
set statusline+=%l:%c\                                      "Row and Column

set laststatus=2
hi StatusLine ctermbg=6 ctermfg=0
hi User1 ctermbg=0 ctermfg=1
hi User2 ctermbg=0 ctermfg=2
