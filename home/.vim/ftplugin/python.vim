nnoremap <buffer> <leader>d oimport pdb; pdb.set_trace()<esc>^
nnoremap <buffer> <leader>D Oimport pdb; pdb.set_trace()<esc>^
nnoremap <buffer> <silent> <leader>f :g/^ *import pdb; pdb.set_trace()$/d<cr>
