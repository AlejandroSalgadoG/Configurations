au BufNewFile *.sh :call Bash()

let cmd=g:cmd_inter

function! Bash()
    exe "normal i#!/bin/bash"
endfunction
