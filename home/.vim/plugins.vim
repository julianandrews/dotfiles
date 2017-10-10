call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'
Plug 'Quramy/tsuquyomi' 
Plug 'dart-lang/dart-vim-plugin'
call plug#end()

Glug youcompleteme-google
Glug piper plugin[mappings]
Glug critique plugin[mappings]
Glug blaze plugin[mappings]
Glug syntastic-google
Glug grok
Glug codefmt
Glug codefmt-google

" tsuquyomi
let g:tsuquyomi_use_dev_node_module = 2
let g:tsuquyomi_tsserver_path = '/google/src/head/depot/google3/third_party/javascript/node_modules/typescript/stable/lib/tsserver.js'
nnoremap <silent> <leader>h :echo tsuquyomi#hint()<CR>

" dart codefmt-google
augroup autoformat_settings
  autocmd FileType dart AutoFormatBuffer dartfmt
augroup END

" fzf
set rtp+=~/.fzf
nnoremap <leader>f :Files<cr>

" grok
nnoremap <leader>s :GrokDef<cr>

" YCM
nnoremap <leader>j :YcmCompleter GoToDefinition<cr>
nnoremap <leader>J :YcmCompleter GoToReferences<cr>
if !exists("g:ycm_semantic_triggers")
   let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:EclimCompletionMethod = 'omnifunc'
