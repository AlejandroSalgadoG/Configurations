au BufNewFile *.c :call C()

let cmd="./".g:name." ".g:args

function! C()
    exe "normal i#include <stdio.h>\n\n
        \int main(int argc, char *argv[]){\n\n\n\n
        \return 0;\n
        \}"
    exe "normal 3k"
    exe "normal i\t"
endfunction

function! Hpp()
    exe "normal i#pragma once"
    exe "normal o"
endfunction
