set number
set clipboard=unnamed
set mouse=a
set hlsearch
set cursorline
set wildmenu

set undofile
set undodir=~/.vim/undodir//

set t_Co=256
set background=dark
colorscheme solarized

augroup autoformat_settings
  au FileType typescript AutoFormatBuffer clang-format
augroup END
