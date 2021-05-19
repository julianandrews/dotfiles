function! StatusFormat(text)
  return a:text != "" ? "[" . a:text . "] " : ""
endfunction

function! FiletypeStatus()
  return StatusFormat(&filetype)
endfunction

function! LinterStatus() abort
    let l:buf = bufnr('')
    let l:errors = luaeval("vim.lsp.diagnostic.get_count(" . l:buf . ", [[Error]])")
    let l:warnings = luaeval("vim.lsp.diagnostic.get_count(" . l:buf . ", [[Warning]])")

    if l:errors == 0 && l:warnings == 0
        return '✓ ok'
    else
        return printf('⚠ %d x %d', warnings, errors)
    endif
endfunction

" Status Line
set statusline=%<                                           "Truncation Point
set statusline+=%1*%h%r%w%m%*                               "Flags
set statusline+=%f\                                         "File Name
set statusline+=%2*%{FiletypeStatus()}%*                    "File Type
set statusline+=%=                                          "Right Align
set statusline+=%9*%{LinterStatus()}%*\                     "Linter
set statusline+=%l:%c\                                      "Row and Column

set laststatus=2
hi StatusLine ctermbg=6 ctermfg=0
hi User1 ctermbg=0 ctermfg=1
hi User2 ctermbg=0 ctermfg=2
hi User3 ctermbg=0 ctermfg=3
hi User4 ctermbg=0 ctermfg=4
hi User9 ctermbg=0 ctermfg=9
