" Autoinstall vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/syntastic'
Plug 'valloric/youcompleteme', { 'do': './install.py' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'
Plug 'hynek/vim-python-pep8-indent'

Plug 'ternjs/tern_for_vim'
Plug 'pangloss/vim-javascript'
Plug 'stephpy/vim-yaml'
Plug 'saltstack/salt-vim'
Plug 'glench/vim-jinja2-syntax'
call plug#end()

filetype plugin indent on

set rtp+=~/.fzf

" Syntastic config
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_signs = 0
let g:syntastic_python_checkers = ['python', 'pylint', 'flake8']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_haskell_checkers = ['hlint']
hi SyntasticError ctermbg=9 ctermfg=0
