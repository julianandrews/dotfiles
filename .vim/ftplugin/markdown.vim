setlocal complete+=kspell
setlocal spell
setlocal spelllang=en
autocmd BufEnter <buffer> lua require'completion'.on_attach()
