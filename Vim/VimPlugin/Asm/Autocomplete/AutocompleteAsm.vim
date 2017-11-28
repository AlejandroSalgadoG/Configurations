au BufNewFile *.asm :call Asm()

function! Asm()
    exe "normal isection .data\n\n\n
        \section .text\n
        \\tglobal _start\n\n
        \\b_start:\n\n\t\n\n\n
        \\b_end:\n
        \\tmov eax, 1\n
        \mov ebx, 0\n
        \int 0x80"
    exe "normal 5k"
endfunction
