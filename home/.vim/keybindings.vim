" Remap leader key to space
noremap <space> <nop>
let mapleader = "\<space>"

" fzf
nnoremap <leader>f :Files<cr>
nnoremap <leader>F :GitFiles<cr>
nnoremap <leader>c :Commits<cr>
nnoremap <leader>r :History:<cr>

" YouCompleteMe
nnoremap <leader>j :YcmCompleter GoTo<cr>
nnoremap <leader>J :YcmCompleter GoToReferences<cr>

" Toggle search highlighting
nnoremap <silent> <leader>/ :noh<cr>

" Cycle through quickfix/location lists
fun! CycleList(nextcom, firstcom)
    try
        try
            execute a:nextcom
        catch /^Vim\%((\a\+)\)\=:E553/
            execute a:firstcom
        catch /^Vim\%((\a\+)\)\=:E776/
        endtry
    catch /^Vim\%((\a\+)\)\=:E42/
    endtry
endfun

nnoremap <silent> <F1> :call CycleList("lnext", "lfirst")<cr>
nnoremap <silent> <F2> :call CycleList("lprev", "llast")<cr>
nnoremap <silent> <F3> :call CycleList("cnext", "cfirst")<cr>
nnoremap <silent> <F4> :call CycleList("cprev", "clast")<cr>

" Paste from PRIMARY buffer
nnoremap <leader>p "+p
vnoremap <leader>p "+p
inoremap <S-Insert> <C-R>+
