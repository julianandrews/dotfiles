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
set cmdheight=2
set updatetime=300
set shiftwidth=4 tabstop=4 softtabstop=4

set t_Co=256
set background=dark
set signcolumn=yes
highlight SignColumn ctermbg=Black

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

command! -nargs=+ Grep execute 'silent grep! <args>' | redraw!
