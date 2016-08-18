setlocal shiftwidth=4 tabstop=4 softtabstop=4

" pdb mappings
nnoremap <buffer> <leader>d oimport pdb; pdb.set_trace()<esc>^
nnoremap <buffer> <leader>D Oimport pdb; pdb.set_trace()<esc>^

" use pylint-django where available
let output=system('python -c "import pylint_django" &> /dev/null')
if !v:shell_error
  let g:syntastic_python_pylint_args = "--load-plugins pylint_django"
endif
