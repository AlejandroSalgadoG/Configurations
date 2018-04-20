au BufNewFile *.m :call Octave()

let cmd=g:cmd_inter

function! Octave()
    exe "normal i#!/usr/bin/octave -q"
endfunction
