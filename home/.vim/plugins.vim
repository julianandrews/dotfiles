" Autoinstall vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'maralla/completor.vim', { 'do': 'make js' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'
Plug 'hynek/vim-python-pep8-indent'

Plug 'davidhalter/jedi-vim'
Plug 'pangloss/vim-javascript'
Plug 'stephpy/vim-yaml'
Plug 'saltstack/salt-vim'
Plug 'glench/vim-jinja2-syntax'
Plug 'rust-lang/rust.vim'
call plug#end()

filetype plugin indent on

set rtp+=~/.fzf

" Ale config
let g:ale_linters = {
      \'python': ['flake8'],
      \'javascript': ['eslint'],
      \'haskell': ['hlint'],
      \'rust': ['cargo'],
      \'java': ['javac'],
      \}
let g:ale_set_signs = 0
let g:ale_statusline_format = ['x %d', '⚠ %d', '⬥ ok']
let g:ale_set_highlights = 0
hi link AleError ErrorMsg
hi link AleWarning WarningMsg

" Completor config
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" Jedi config
let g:jedi#auto_initialization = 0
