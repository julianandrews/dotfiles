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

if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/lsp_extensions.nvim'
    Plug 'nvim-lua/completion-nvim'
endif

" Language specific plugins
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-markdown'
Plug 'dart-lang/dart-vim-plugin', { 'for': ['dart'] }
Plug 'hynek/vim-python-pep8-indent', { 'for': ['python'] }
Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }
Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }

call plug#end()

filetype plugin indent on

" Configure colorscheme
colorscheme solarized
set t_Co=256
set background=dark
set signcolumn=yes
highlight SignColumn ctermbg=Black

" nvim-lsp
if has('nvim')
    source $HOME/.vim/nvim_lsp.vim
endif

" fzf
set rtp+=~/.fzf
command! -bang -nargs=* GitFiles call fzf#run(fzf#vim#with_preview(fzf#wrap({'source':
            \"bash -c 'git diff --name-only HEAD~ && git ls-files -o --exclude-standard'"})))
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Files %:p:h<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>h :GitFiles<cr>

" vim-terraform
let g:terraform_fmt_on_save=1

" vim-markdown
let g:markdown_fenced_languages = ['terraform', 'python', 'rust', 'js=javascript', 'json']
