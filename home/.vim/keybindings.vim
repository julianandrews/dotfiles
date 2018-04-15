" Cycle through quickfix/location lists
fun! CycleList(nextcom, firstcom)
    try
        execute a:nextcom
    catch /^Vim\%((\a\+)\)\=:E553/
        execute a:firstcom
    catch /^Vim\%((\a\+)\)\=:E\(42\|776\)/
    endtry
endfun

" Remap leader key to space
noremap <space> <nop>
let mapleader = "\<space>"

" Toggle search highlighting
nnoremap <silent> <leader>/ :noh<cr>

nnoremap <silent> <F1> :call CycleList("lprev", "llast")<cr>
nnoremap <silent> <F2> :call CycleList("lnext", "lfirst")<cr>
nnoremap <silent> <F3> :call CycleList("cprev", "clast")<cr>
nnoremap <silent> <F4> :call CycleList("cnext", "cfirst")<cr>

" Paste from PRIMARY buffer
nnoremap <leader>p "+p
vnoremap <leader>p "+p
inoremap <S-Insert> <C-R>+

" YouCompleteMe keybindings
nnoremap <leader>j :YcmCompleter GoTo<cr>
nnoremap <leader>J :YcmCompleter GoToReferences<cr>
