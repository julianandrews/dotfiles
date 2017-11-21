call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'
Plug 'dart-lang/dart-vim-plugin'
Plug 'w0rp/ale'
call plug#end()

Glug youcompleteme-google
Glug codefmt
Glug codefmt-google

augroup autoformat_settings
  autocmd!
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType proto AutoFormatBuffer clang-format
  autocmd FileType textpb AutoFormatBuffer text-proto-format
augroup END

" fzf
set rtp+=~/.fzf
nnoremap <leader>f :Files<cr>

" YCM
nnoremap <leader>j :YcmCompleter GoToDefinition<cr>
nnoremap <leader>J :YcmCompleter GoToReferences<cr>
if !exists("g:ycm_semantic_triggers")
   let g:ycm_semantic_triggers = {}
endif
let g:EclimCompletionMethod = 'omnifunc'
