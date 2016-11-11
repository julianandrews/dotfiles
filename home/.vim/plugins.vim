" Autoinstall vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --tern-completer --racer-completer' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'
Plug 'hynek/vim-python-pep8-indent'

Plug 'ternjs/tern_for_vim'
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
      \}
let g:ale_set_signs = 0
let g:ale_statusline_format = ['x %d', '⚠ %d', '⬥ ok']
