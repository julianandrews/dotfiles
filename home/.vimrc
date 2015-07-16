set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" manually installed bundles
Plugin 'Valloric/YouCompleteMe'
Plugin 'wincent/command-t'
Plugin 'mileszs/ack.vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

set expandtab
set softtabstop=2
set shiftwidth=2
set number
set background=dark
set clipboard^=unnamedplus
set backspace=2
set hlsearch
syntax on

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

let g:CommandTFileScanner='find'
set wildignore+=*.pyc
