" Autoinstall vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --tern-completer --racer-completer' }
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'

Plug 'hynek/vim-python-pep8-indent', { 'for': ['python'] }
Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }
Plug 'rust-lang/rust.vim', { 'for': ['rust'] }

Plug 'ternjs/tern_for_vim', { 'for': ['javascript'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript'] }

call plug#end()

filetype plugin indent on

set rtp+=~/.fzf

" Ale config
let g:ale_linters = {
      \'python': ['flake8'],
      \'javascript': ['eslint'],
      \'haskell': ['hlint'],
      \'rust': ['cargo'],
      \'java': ['javac'],
      \'cpp': ['clang'],
      \}
let g:ale_fixers = {
      \'cpp': ['clang-format'],
      \}
let g:ale_set_signs = 0
let g:ale_statusline_format = ['x %d', '⚠ %d', '⬥ ok']
let g:ale_set_highlights = 1
let g:ale_type_map = {'flake8': {'ES': 'WS'}}
let g:ale_fix_on_save = 1

" vim-jsx config
let g:jsx_ext_required = 0

" fzf
if executable("rg")
    command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
          \   <bang>0 ? fzf#vim#with_preview('up:60%')
          \           : fzf#vim#with_preview('right:50%:hidden', '?'),
          \   <bang>0)

    nnoremap <C-p>a :Rg
endif
nnoremap <leader>f :Files<cr>
