if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-commentary'
  Plug 'altercation/vim-colors-solarized'
  Plug 'w0rp/ale'
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'

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
  Glug csearch
  " Glug youcompleteme-google
  Glug blazedeps
  Glug g4
  Glug glint-ale
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

" csearch
let g:csearch_options = '--search_service_bns="" --enable_local_proxy --max_num_results=50'

" ycm
let g:ycm_enable_diagnostic_signs = 0

" ale
let g:ale_set_signs = 0
let g:ale_set_highlights = 1
let g:ale_linters = {
      \'cpp': ['glint', 'clangtidy'],
      \'html': ['glint'],
      \'java': ['glint'],
      \'javascript': ['glint'],
      \'python': ['glint'],
      \'proto': ['glint'],
      \'typescript': ['glint'],
      \}
let g:ale_cpp_clangtidy_executable = 'clang_tidy'
let g:ale_cpp_clangtidy_checks = ['-cppcoreguidelines-pro-bounds-array-to-pointer-decay,-cppcoreguidelines-pro-bounds-pointer-arithmetic']

hi link ALEWarningLine warning
hi link ALEErrorLine error

" vim-lsp config
nnoremap gd :LspDefinition<cr>
nnoremap gr :LspReferences<cr>

if executable('/google/data/ro/teams/grok/tools/kythe_languageserver')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'Kythe Language Server',
        \ 'cmd': {server_info->['/google/data/ro/teams/grok/tools/kythe_languageserver', '--google3']},
        \ 'whitelist': ['python', 'go', 'java', 'cpp', 'proto', 'typescript'],
        \})
endif
