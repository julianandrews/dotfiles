" Remap leader key to space
noremap <space> <nop>
let mapleader = "\<space>"

" Toggle search highlighting
nnoremap <silent> <leader>/ :noh<cr>

" Cycle through quickfix/location lists
function! CycleList(nextcom, firstcom)
  try
    execute a:nextcom
  catch /^Vim\%((\a\+)\)\=:E553/
    execute a:firstcom
  catch /^Vim\%((\a\+)\)\=:E\(42\|776\)/
  endtry
endfunction

nnoremap <silent> <F3> :call CycleList("cprev", "clast")<cr>
nnoremap <silent> <F4> :call CycleList("cnext", "cfirst")<cr>

" Paste from PRIMARY buffer
nnoremap <S-Insert> "+p
vnoremap <S-Insert> "+p
inoremap <S-Insert> <C-R>+

function! JTSwap()
  let l:cwd = getcwd()
  if l:cwd =~ "\/java\/"
    execute "cd" substitute(l:cwd, "/java/", "/javatests/", "")
  elseif l:cwd =~ "\/javatests\/"
    execute "cd" substitute(l:cwd, "/javatests/", "/java/", "")
  endif
endfunction

command! JTSwap call JTSwap()
