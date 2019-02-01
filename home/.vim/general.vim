set number
set clipboard=unnamed
set mouse=a
set hlsearch
set cursorline
set wildmenu
set completeopt-=preview

set undofile
set undodir=~/.vim/undodir//

set t_Co=256
set background=dark
set ttymouse=urxvt
colorscheme solarized

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" This function allows a Java symbol to be imported using CodeSearch. It
" works a lot like it does in Cider.
function! ImportJavaSymbol()
  " Lookup the symbol in CodeSearch
  let query = "/usr/bin/cs -h --corpus=google3 -- lang:java case:yes '^import\\ .*\\." . expand("<cword>") . ";$'"
  " echom query

  " Deduplicate the results and sort by frequency
  let results = system(query . " 2> /dev/null | sed -E 's/^[0-9]+: //' | sort | uniq -c | sort -rn | sed -E 's/.*import /import /'")
  let numresults = len(substitute(results, '[^\n]', '', 'g'))
  let results = results[:-2] " strips the empty last line

  if numresults > 1
    " Multiple results. Show options in a temporary buffer where <Enter>
    " selects the import statement and closes the temporary buffer.
    belowright new
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
    exe 'resize' . string(numresults)
    set paste
    exe "normal! i" . results
    exe "normal! gg"
    set nopaste
    nnoremap <buffer> <CR> yy:q<CR>2Gpjvip:sort<CR><C-O>
  else
   " Only option. Insert and show at the command line the imported statment.
    set paste
    exe "normal! 2Go" . results . "\<Esc>jvip:sort\<CR>\<C-O>"
    set nopaste
    echom results
  endif
  if exists(":FormatCode")
    FormatCode
  endif
endfunction

function! FormatChangedLines()
  if (filereadable(@%))
    silent let lines = systemlist("diff --unchanged-line-format=\"\" --old-line-format=\"\" --new-line-format=\"\%dn\%c'\012'\" " . expand("%:p") . " -", bufnr('%'))
    exe join(lines, ",") . "FormatLines"
  endif
endfunction
