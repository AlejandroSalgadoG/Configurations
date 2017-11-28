au BufNewFile *.m :call Octave()

function! Octave()
    exe "normal i#!/usr/bin/octave -q"
endfunction
