set shiftwidth=2 tabstop=2 softtabstop=2

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
