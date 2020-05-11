" Autoinstall vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'hashivim/vim-terraform'
Plug 'dart-lang/dart-vim-plugin', { 'for': ['dart'] }
Plug 'hynek/vim-python-pep8-indent', { 'for': ['python'] }
Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }
Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }

call plug#end()

filetype plugin indent on

colorscheme solarized

source $HOME/.vim/coc-config.vim

" fzf
set rtp+=~/.fzf
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Files %:p:h<cr>
nnoremap <leader>b :Buffers<cr>

" vim-terraform
let g:terraform_fmt_on_save=1
