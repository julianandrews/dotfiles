if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-commentary'
  Plug 'altercation/vim-colors-solarized'
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'

  Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp'] }
  Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
  call plug#end()
endif

if exists('g:installed_glug')
  Glug codefmt
  Glug codefmt-google
  Glug blazedeps
  Glug google-csimporter
endif

augroup autoformat_settings
  autocmd!
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp NoAutoFormatBuffer
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer pyformat
  autocmd FileType javascript AutoFormatBuffer clang-format
  autocmd FileType proto AutoFormatBuffer clang-format
  autocmd FileType textpb AutoFormatBuffer text-proto-format
  autocmd FileType typescript AutoFormatBuffer clang-format
augroup END

" fzf
set rtp+=~/.fzf

" Get changed fig files.
function! GetFigFiles() abort
  let syscall_info =
        \ maktaba#syscall#Create('HGPLAIN=1 hg status --rev "parents(.)" -maun').Call()
  let found = split(l:syscall_info.stdout, "\n")
  if len(found) == 0
    echo 'Could not find any active files'
    return []
  endif

  let root_directory = piperlib#GetRootDir()
  let processed = []
  for prep in found
    let fullpath = maktaba#path#Join([root_directory, prep])
    let relpath = fnamemodify(fullpath, ':.')
    if filereadable(relpath) &&
          \ match(relpath, '_meta$') == -1  " Don't show HIP metadata
      call add(processed, relpath)
    endif
  endfor

  return processed
endfunction

nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Files %:p:h<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <silent> <leader>h :call fzf#run(fzf#wrap(
      \ 'piper-files', {
      \ 'source': GetFigFiles(),
      \ }))<CR>

" vim-cpp-enhanced-highlight
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1

" vim-lsp
au User lsp_setup call lsp#register_server({
    \ 'name': 'CiderLSP',
    \ 'cmd': {server_info->[
    \   '/google/bin/releases/editor-devtools/ciderlsp',
    \   '--tooltag=vim-lsp',
    \   '--noforward_sync_responses',
    \ ]},
    \ 'whitelist': ['proto', 'textproto', 'go', 'java', 'python'],
    \})

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>
nnoremap <silent> <F1> :LspPreviousError<CR>
nnoremap <silent> <F2> :LspNextError<CR>
let g:lsp_async_completion = 1
let g:lsp_signs_enabled = 0
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '⚠️'}
let g:lsp_signs_information = {'text': 'ⓘ'}
let g:lsp_signs_hint = {'text': 'ⓘ'}
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1

" vim-lsp tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)
