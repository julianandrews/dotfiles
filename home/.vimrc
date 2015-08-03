set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" manually installed bundles
Plugin 'Valloric/YouCompleteMe'
Plugin 'wincent/command-t'
Plugin 'mileszs/ack.vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

syntax on
set expandtab
set softtabstop=2 shiftwidth=2
set number
set background=dark
set clipboard^=unnamed
set backspace=2
set t_Co=256
set laststatus=2
set wildignore+=*.pyc
set mouse=a
set hlsearch
hi CursorLine term=NONE cterm=NONE ctermbg=8

" Ack config
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Airline config
let g:airline_right_sep = '◀'
let g:airline_left_sep = '▶'

" Syntastic config
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['python', 'flake8']
let g:syntastic_javascript_checkers = ['eslint']

" CommandT config
let g:CommandTFileScanner='find'

" Clear trailing whitespace in .py files on save
autocmd BufWritePre *.py :%s/\s\+$//e

" Toggle search highlighting on/off
nnoremap <Leader>/ :let @/ = "" <bar> set nocursorline<CR>
" Toggle cursorline highlighting on/off
nnoremap <Leader>? :set cursorline!<CR>
nnoremap <Tab> :set cursorline <bar> lnext<CR>
nnoremap <S-Tab> :set cursorline <bar> lprevious<CR>
