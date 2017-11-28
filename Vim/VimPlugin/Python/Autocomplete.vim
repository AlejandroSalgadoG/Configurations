au BufNewFile *.py :call Python()

function! Python()
    exe "normal i#!/bin/python"
endfunction
