" Autoinstall vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'

Plug 'hynek/vim-python-pep8-indent', { 'for': ['python'] }
Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }
Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }

call plug#end()

filetype plugin indent on

" Ale config
let g:ale_linters = {
      \'python': ['flake8'],
      \'javascript': ['eslint'],
      \'haskell': ['hlint'],
      \'rust': ['rls'],
      \'java': ['javac'],
      \'cpp': ['clang'],
      \}
let g:ale_fixers = {
      \'cpp': ['clang-format'],
      \'rust': ['rustfmt'],
      \}
let g:ale_set_signs = 0
let g:ale_set_highlights = 1
let g:ale_type_map = {'flake8': {'ES': 'WS'}}
let g:ale_fix_on_save = 1
hi link ALEWarningLine warning
hi link ALEErrorLine error

" fzf
set rtp+=~/.fzf
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Files %:p:h<cr>
nnoremap <leader>b :Buffers<cr>

" vim-lsp config
let g:lsp_log_file = '/tmp/vim-lsp.log'
nnoremap gd :LspDefinition<cr>
nnoremap gr :LspReferences<cr>

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

" asyncomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
