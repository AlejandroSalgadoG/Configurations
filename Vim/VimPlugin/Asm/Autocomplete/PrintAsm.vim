function! PrintAsm()
    exe "normal o\tmov eax, 4\n
        \mov ebx, 1\n
        \mov ecx, \n
        \mov edx, 1\n
        \int 80h"
    exe "normal kk"
endfunction
