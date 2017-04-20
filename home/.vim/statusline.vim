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
  if exists("b:gitstatus")
    return StatusFormat(b:gitstatus)
  else
    return ""
  endif
endfunction

function! SetGitStatus(...)
  let l:gitstatus = system("bash -c 'source /usr/lib/git-core/git-sh-prompt && cd \"" . expand('%:p:h') . "\" && __git_ps1'")
  let l:length = len(l:gitstatus)
  if l:length > 3
    let b:gitstatus = strpart(l:gitstatus, 2, l:length - 3)
  else
    let b:gitstatus = ""
  endif
  " redrawstatus!
endfunction

" autocmd! VimEnter,BufNewFile,BufRead,BufWritePost,ShellCmdPost * silent! call SetGitStatus()
" call timer_start(1000, 'SetGitStatus', {'repeat': -1})

" Status Line
set statusline=%<                                           "Truncation Point
set statusline+=%1*%h%r%w%m%*                               "Flags
set statusline+=%f\                                         "File Name
set statusline+=%2*%{FiletypeStatus()}%*                    "File Type
" set statusline+=%3*%{GitStatus()}%*                         "Git Branch
set statusline+=%4*%{VirtualenvStatus()}%*                  "Virtualenv
set statusline+=%=                                          "Right Align
set statusline+=%5*%{ALEGetStatusLine()}%*\                 "Ale
set statusline+=%l:%c\                                      "Row and Column

set laststatus=2
hi StatusLine ctermbg=6 ctermfg=0
hi User1 ctermbg=0 ctermfg=1
hi User2 ctermbg=0 ctermfg=2
hi User3 ctermbg=0 ctermfg=5
hi User4 ctermbg=0 ctermfg=3
hi User5 ctermbg=0 ctermfg=9
