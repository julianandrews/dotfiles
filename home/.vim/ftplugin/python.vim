setlocal shiftwidth=4 tabstop=4 softtabstop=4

" pdb mappings
nnoremap <buffer> <leader>d oimport pdb; pdb.set_trace()<esc>^
nnoremap <buffer> <leader>D Oimport pdb; pdb.set_trace()<esc>^
