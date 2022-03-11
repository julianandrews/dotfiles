" pdb mappings
nnoremap <buffer> <leader>d oimport pdb; pdb.set_trace()<esc>^
nnoremap <buffer> <leader>D Oimport pdb; pdb.set_trace()<esc>^

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
