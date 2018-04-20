au BufNewFile *.py :call Python()

let cmd=g:cmd_inter

function! Python()
    exe "normal i#!/bin/env python"
    exe "normal 2o"
    exe "normal idef main():\n\n\n"
    exe "normal iif __name__ == '__main__':\n"
    exe "normal i   main()"
    exe "normal 3k"
    exe "normal i    "
endfunction
