function! StatusFormat(text)
  return a:text != "" ? "[" . a:text . "] " : ""
endfunction

function! FiletypeStatus()
  return StatusFormat(&filetype)
endfunction

function! LinterStatus() abort
    let l:counts = lsp#ui#vim#diagnostics#get_buffer_diagnostics_counts()

    let l:all_errors = l:counts.error
    let l:all_non_errors = l:counts.warning + l:counts.information + l:counts.hint

    return l:all_errors == 0 && l:all_non_errors == 0 ? '✓ ok' : printf(
    \   '⚠ %d x %d',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" Status Line
set statusline=%<                                           "Truncation Point
set statusline+=%1*%h%r%w%m%*                               "Flags
set statusline+=%f\                                         "File Name
set statusline+=%2*%{FiletypeStatus()}%*                    "File Type
set statusline+=%=                                          "Right Align
set statusline+=%4*%{LinterStatus()}%*\                     "Linter
set statusline+=%l:%c\                                      "Row and Column

set laststatus=2
hi StatusLine ctermbg=6 ctermfg=0
hi User1 ctermbg=0 ctermfg=1
hi User2 ctermbg=0 ctermfg=2
hi User3 ctermbg=0 ctermfg=3
hi User4 ctermbg=0 ctermfg=9
