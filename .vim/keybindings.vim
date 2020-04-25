" Cycle through quickfix/location lists e.g.:
" nnoremap <silent> <F1> :call CycleList("lprev", "llast")<cr>
fun! CycleList(nextcom, firstcom)
    try
        execute a:nextcom
    catch /^Vim\%((\a\+)\)\=:E553/
        execute a:firstcom
    catch /^Vim\%((\a\+)\)\=:E\(42\|776\)/
    endtry
endfun

function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

" Remap leader key to space
noremap <space> <nop>
let mapleader = "\<space>"

" Toggle search highlighting
nnoremap <silent> <leader>/ :noh<cr>

" Paste from PRIMARY buffer
nnoremap <leader>p "+p
vnoremap <leader>p "+p
inoremap <S-Insert> <C-R>+

" Easier splits
map <silent> <C-h> :call WinMove('h')<cr>
map <silent> <C-j> :call WinMove('j')<cr>
map <silent> <C-k> :call WinMove('k')<cr>
map <silent> <C-l> :call WinMove('l')<cr>
