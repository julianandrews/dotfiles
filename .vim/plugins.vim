" Autoinstall vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-commentary'
Plug 'sbdchd/neoformat'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Neovim specific plugins
Plug 'neovim/nvim-lspconfig', has('nvim') ? {} : { 'on': [] }

" Language specific plugins
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-markdown'
Plug 'dart-lang/dart-vim-plugin', { 'for': ['dart'] }
Plug 'hynek/vim-python-pep8-indent', { 'for': ['python'] }
Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }
Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
Plug 'towolf/vim-helm'

call plug#end()

filetype plugin indent on

" Configure colorscheme
silent! colorscheme solarized
highlight SignColumn ctermbg=Black

" neovim lsp configuration
if has('nvim')
    lua require ("nvim_lsp_config")
    nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
    nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<cr>
    nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> gn <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> g[ <cmd>lua vim.diagnostic.jump({count=-1})<CR>
    nnoremap <silent> g] <cmd>lua vim.diagnostic.jump({count=1})<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<cr>
endif

" fzf
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Files %:p:h<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>h :GFiles<cr>

" neoformat
let g:neoformat_enabled_python = ['black']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_try_node_exe = 1

" vim-terraform
let g:terraform_fmt_on_save=1

" vim-markdown
let g:markdown_fenced_languages = ['terraform', 'python', 'rust', 'js=javascript', 'json']
