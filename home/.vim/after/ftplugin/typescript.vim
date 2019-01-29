function! OnTazeErr(channel)
  while ch_status(a:channel, {'part': 'err'}) == 'buffered'
    echoerr ch_read(a:channel, {'part': 'err'})
  endwhile
endfunction

function! RunTaze()
  " Make sure we're running VIM version 8 or higher.
  if v:version < 800
    echoerr 'RunTaze requires VIM version 8 or higher'
    return
  endif
  " Launch the taze job.
  call job_start('taze -files ' . expand('%:p'), {'close_cb': 'OnTazeErr'})
endfunction

" So we can use :RunTaze to call our function.
command! RunTaze call RunTaze()
