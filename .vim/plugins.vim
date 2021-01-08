" Must be set before loading ALE
let g:ale_completion_enabled = 1

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
Plug 'dense-analysis/ale'

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

colorscheme solarized

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

" ale
let g:ale_fix_on_save = 1
let g:ale_linters = {
\  'python': ['pyls'],
\  'rust': ['analyzer'],
\}
let g:ale_fixers = {
\  'rust': ['rustfmt', 'remove_trailing_lines', 'trim_whitespace'],
\  'python': [
\    'autopep8',
\    'black',
\    'isort',
\    'remove_trailing_lines',
\    'reorder-python-imports',
\    'trim_whitespace'
\  ]
\}

nnoremap gd :ALEGoToDefinition<cr>
nnoremap gr :ALEFindReferences<cr>
nnoremap ]g :ALENextWrap<cr>
nnoremap [g :ALEPreviousWrap<cr>
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"

" vim-markdown
let g:markdown_fenced_languages = ['terraform', 'python', 'rust', 'js=javascript', 'json']
