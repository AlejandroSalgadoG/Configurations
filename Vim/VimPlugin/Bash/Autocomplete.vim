au BufNewFile *.sh :call Bash()

function! Bash()
    exe "normal i#!/bin/bash"
endfunction
