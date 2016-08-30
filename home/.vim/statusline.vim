function! StatusFormat(text)
  return a:text != "" ? "[" . a:text . "] " : ""
endfunction

function! FiletypeStatus()
  return StatusFormat(&filetype)
endfunction

function! VirtualenvStatus()
  return StatusFormat(([""] + split($VIRTUAL_ENV, "/"))[-1])
endfunction

function! GitStatus()
  return StatusFormat(fugitive#head())
endfunction

" Status Line
set statusline=%<\                                          "Truncation Point
set statusline+=%1*%h%r%w%m%*\                              "Flags
set statusline+=%f\                                         "File Name
set statusline+=%2*%{FiletypeStatus()}%*                    "File Type
set statusline+=%3*%{GitStatus()}%*                         "Git Branch
set statusline+=%4*%{VirtualenvStatus()}%*                  "Virtualenv
set statusline+=%=                                          "Right Align
set statusline+=%#warningmsg#%{SyntasticStatuslineFlag()}%* "Syntastic
set statusline+=%l:%c\                                      "Row and Column

set laststatus=2
hi StatusLine ctermbg=6 ctermfg=0
hi User1 ctermbg=0 ctermfg=1
hi User2 ctermbg=0 ctermfg=2
hi User3 ctermbg=0 ctermfg=5
hi User4 ctermbg=0 ctermfg=3

