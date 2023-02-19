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
Plug 'sbdchd/neoformat'

" Neovim specific plugins
Plug 'neovim/nvim-lspconfig', has('nvim') ? {} : { 'on': [] }
Plug 'simrat39/rust-tools.nvim', has('nvim') ? {} : { 'on': [] }

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

" neo-vim specific config
if has('nvim')
    lua require ("rust_tools_config")
    lua require ("nvim_lsp_config")

    nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
    nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<cr>
    nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> gn <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<cr>
    nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
    nnoremap <silent> ff <cmd>lua vim.lsp.buf.formatting()<CR>
endif

" fzf
set rtp+=~/.fzf
command! -bang -nargs=* GitFiles call fzf#run(fzf#vim#with_preview(fzf#wrap({'source':
            \"bash -c 'git diff --name-only HEAD~ && git ls-files -o --exclude-standard'"})))
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Files %:p:h<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>h :GitFiles<cr>

" neoformat
let g:neoformat_enabled_python = ['black']
let g:neoformat_enabled_typescript = ['prettier']

" vim-terraform
let g:terraform_fmt_on_save=1

" vim-markdown
let g:markdown_fenced_languages = ['terraform', 'python', 'rust', 'js=javascript', 'json']
