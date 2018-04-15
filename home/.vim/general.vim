syntax on
set expandtab
set number
set clipboard=unnamed
set backspace=2
set lazyredraw
set mouse=a
set hlsearch
set cursorline
set wildmenu
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

command! -nargs=+ Grep execute 'silent grep! <args>' | redraw!
