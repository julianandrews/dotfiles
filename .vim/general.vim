if !has('nvim')
    source $HOME/.vim/nvim_defaults.vim
    " nvim defaults to ~/.local/share/nvim/undo and the format isn't compatible.
    set undodir=~/.vim/undo//
endif

set clipboard=unnamed
set cmdheight=2
set completeopt=menuone,noinsert,noselect
set cursorline
set expandtab
set hidden
set lazyredraw
set number
set mouse=a
set updatetime=300
set undofile
set signcolumn=yes
set shiftwidth=4 tabstop=4 softtabstop=4
set title
set t_Co=256

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
