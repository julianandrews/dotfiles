function! StatusFormat(text)
  return a:text != "" ? "[" . a:text . "] " : ""
endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '✓ ok' : printf(
    \   '⚠ %d x %d',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" Status Line
set statusline=%<                                           "Truncation Point
set statusline+=%1*%h%r%w%m%*                               "Flags
set statusline+=%f\                                         "File Name
set statusline+=%2*%{StatusFormat(&filetype)}%*             "File Type
set statusline+=%=                                          "Right Align
set statusline+=%3*%{LinterStatus()}%*\                     "Linter
set statusline+=%l:%c\                                      "Row and Column

set laststatus=2

" Colors for status line
hi StatusLine ctermbg=6 ctermfg=0
hi User1 ctermbg=0 ctermfg=1
hi User2 ctermbg=0 ctermfg=2
hi User3 ctermbg=0 ctermfg=9
