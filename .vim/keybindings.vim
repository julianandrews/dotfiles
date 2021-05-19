" Toggle search highlighting
nnoremap <silent> <leader>/ :noh<cr>

" Paste from PRIMARY buffer
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Shift insert pastes primary buffer in insert mode
inoremap <S-Insert> <C-R>+
