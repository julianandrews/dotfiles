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
set completeopt=menuone,noinsert,noselect
set hidden
set cmdheight=2
set updatetime=300
set shiftwidth=4 tabstop=4 softtabstop=4
set undofile

if has('nvim')
    set undodir=~/.vim/undodir/nvim//
else
    set undodir=~/.vim/undodir/vim//
endif

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
