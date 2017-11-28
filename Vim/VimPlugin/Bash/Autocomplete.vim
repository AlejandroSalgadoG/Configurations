au BufNewFile *.sh :call Bash()

function! Bash()
    exe "normal i#!/usr/bin/bash"
endfunction
