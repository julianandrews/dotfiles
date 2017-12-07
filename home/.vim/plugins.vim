call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'
Plug 'dart-lang/dart-vim-plugin'
Plug 'w0rp/ale'
Plug 'natebosch/vim-lsc'

Plug 'hynek/vim-python-pep8-indent', { 'for': ['python'] }
Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }
Plug 'rust-lang/rust.vim', { 'for': ['rust'] }

Plug 'ternjs/tern_for_vim', { 'for': ['javascript'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript'] }
call plug#end()

Glug youcompleteme-google
Glug codefmt
Glug codefmt-google
Glug csearch

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

" csearch
let g:csearch_options = '--search_service_bns="" --enable_local_proxy --max_num_results=50'

" fzf
set rtp+=~/.fzf
nnoremap <leader>f :Files<cr>

" ycm
nnoremap <leader>j :YcmCompleter GoToDefinition<cr>
nnoremap <leader>J :YcmCompleter GoToReferences<cr>
if !exists("g:ycm_semantic_triggers")
   let g:ycm_semantic_triggers = {}
endif

" ale
let g:ale_set_signs = 0
let g:ale_statusline_format = ['x %d', '⚠ %d', '✓ ok']
let g:ale_set_highlights = 1
hi link ALEWarningLine warning
hi link ALEErrorLine error

" lsc
let g:lsc_server_commands = {
    \ 'dart': 'dart_language_server',
    \ 'html': 'dart_language_server',
    \}
let g:lsc_auto_map = v:true

" vim-jsx config
let g:jsx_ext_required = 0

" fzf ripgrep
if executable("rg")
    command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
          \   <bang>0 ? fzf#vim#with_preview('up:60%')
          \           : fzf#vim#with_preview('right:50%:hidden', '?'),
          \   <bang>0)

    nnoremap <C-p>a :Rg
endif
