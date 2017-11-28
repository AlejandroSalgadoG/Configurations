au BufNewFile *.asm :call Asm()

function! Asm()
    exe "normal isection .data\n\t\n\n
        \section .text\n
        \\tglobal _start\n\n
        \\b_start:\n\n
        \\tmov eax, 1\n
        \mov ebx, 0\n
        \int 80h"
    exe "normal gg"
    exe "normal j"
    exe "normal llll"
endfunction
