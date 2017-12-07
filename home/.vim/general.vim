syntax on
set expandtab
set shiftwidth=4 tabstop=4 softtabstop=4
set number
set clipboard=unnamed
set backspace=2
set lazyredraw
set wildignore+=*.pyc
set mouse=a
set hlsearch
set cursorline
set wildmenu
set tags=tags
set completeopt=menu
set hidden

set undofile
set undodir=~/.vim/undodir//

set t_Co=256
set background=dark
colorscheme solarized

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

command! -nargs=+ Sgrep execute 'silent grep! <args>' | copen 33
