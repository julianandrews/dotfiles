" Remap leader key to space
noremap <space> <nop>
let mapleader = "\<space>"

" fzf
command! -nargs=+ -bang Rg call fzf#vim#grep(
    \'rg --column --line-number --no-heading --color=always '.<q-args>,
    \1,
    \<bang>0
    \)
nnoremap <leader>f :Files<cr>

" Toggle search highlighting
nnoremap <silent> <leader>/ :noh<cr>

" Cycle through quickfix/location lists
fun! CycleList(nextcom, firstcom)
    try
        execute a:nextcom
    catch /^Vim\%((\a\+)\)\=:E553/
        execute a:firstcom
    catch /^Vim\%((\a\+)\)\=:E\(42\|776\)/
    endtry
endfun

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

nnoremap <silent> <leader>c :set opfunc=ReplaceWithoutOverwrite<cr>g@
function! ReplaceWithoutOverwrite(type)
    if a:type == 'line'
        silent exe "normal! '[V']\"_dp"
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]\"_dp"
    else
        silent exe "normal! `[v`]\"_dp"
    endif
endfunction
