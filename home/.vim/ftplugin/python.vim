" Enable Braceless for python
autocmd FileType python BracelessEnable

" pdb mappings
nnoremap <buffer> <leader>d oimport pdb; pdb.set_trace()<esc>^
nnoremap <buffer> <leader>D Oimport pdb; pdb.set_trace()<esc>^

" Build ctags
noremap <F12> :!ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./tags $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))") ./<cr>
