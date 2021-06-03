setlocal complete+=kspell
setlocal spell
setlocal spelllang=en
if has('nvim')
    autocmd BufEnter <buffer> lua require'completion'.on_attach()
endif
