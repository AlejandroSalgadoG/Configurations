au BufNewFile *.C call Cpp()
au BufNewFile *.h call Hpp()

function! Cpp()
    exe "normal i#include <iostream>\n\n
        \using namespace std;\n\n
        \int main(int argc, char *argv[]){\n\n
        \}"
    exe "normal k"
    exe "normal i\t"
endfunction

function! Hpp()
    exe "normal i#pragma once"
    exe "normal o"
endfunction
