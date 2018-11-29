if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-commentary'
  Plug 'altercation/vim-colors-solarized'
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'vim-syntastic/syntastic'

  Plug 'hynek/vim-python-pep8-indent', { 'for': ['python'] }
  Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }
  Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
  Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
  Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
  call plug#end()
endif

if exists('g:installed_glug')
  Glug glug sources+=`$HOME . '/.vim/glug-local'`
  Glug codefmt
  Glug codefmt-google
  Glug blazedeps
  Glug g4
  Glug relatedfiles plugin[mappings]
  Glug youcompleteme-google
  Glug syntastic-google checkers=`{'proto': ['glint'], 'borg': ['borgcfg'], 'java': ['glint']}`
endif

augroup autoformat_settings
  autocmd!
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType java AutoFormatBuffer google-java-format
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

" ycm
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0

" syntastic
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_enable_signs = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_jump = 1

" vim-lsp config
nnoremap gd :LspDefinition<cr>
nnoremap gr :LspReferences<cr>

if executable('/google/data/ro/teams/grok/tools/kythe_languageserver')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'Kythe Language Server',
        \ 'cmd': {server_info->['/google/data/ro/teams/grok/tools/kythe_languageserver', '--google3']},
        \ 'whitelist': ['python', 'go', 'java', 'cpp', 'proto', 'typescript', 'javascript'],
        \})
endif
