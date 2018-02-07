call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'
Plug 'w0rp/ale'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

Plug 'hynek/vim-python-pep8-indent', { 'for': ['python'] }
Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }
Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
Plug 'leafgarland/typescript-vim'

Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
call plug#end()

Glug codefmt
Glug codefmt-google
Glug csearch
Glug youcompleteme-google
Glug blazedeps

augroup autoformat_settings
  autocmd!
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType javascript AutoFormatBuffer clang-format
  autocmd FileType proto AutoFormatBuffer clang-format
  autocmd FileType textpb AutoFormatBuffer text-proto-format
  autocmd FileType typescript AutoFormatBuffer clang-format
augroup END

" csearch
let g:csearch_options = '--search_service_bns="" --enable_local_proxy --max_num_results=50'

" fzf
set rtp+=~/.fzf
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Files %:p:h<cr>

" ycm
let g:ycm_enable_diagnostic_signs = 0

" ale
let g:ale_set_signs = 0
let g:ale_statusline_format = ['x %d', '⚠ %d', '✓ ok']
let g:ale_set_highlights = 1
let g:ale_linters = {
      \'html': [],
      \'typescript': ['tslint'],
      \'java': [],
      \'cpp': ['clangtidy'],
      \'javascript': [],
      \}
let g:ale_cpp_clangtidy_executable = 'clang_tidy'
let g:ale_cpp_clangtidy_checks = ['-cppcoreguidelines-pro-bounds-array-to-pointer-decay,-cppcoreguidelines-pro-bounds-pointer-arithmetic,-google3-custom-weak-log']
let g:ale_typescript_tslint_config_path = '/usr/local/google/home/julianandrews/.config/tslint.json'

hi link ALEWarningLine warning
hi link ALEErrorLine error

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

" vim-lsp config
au User lsp_setup call lsp#register_server({
    \ 'name': 'Kythe Language Server',
    \ 'cmd': {server_info->['/google/data/ro/teams/grok/tools/kythe_languageserver', '--google3']},
    \ 'whitelist': ['python', 'go', 'java', 'cpp', 'proto', 'typescript'],
    \})

nnoremap gd :LspDefinition<cr>
