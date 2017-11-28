au BufNewFile *.asm :call Asm()

function! Asm()
    exe "normal isection .data\n\t\n\n
        \section .text\n
        \\tglobal _start\n\n
        \\b_start:\n"
    exe "normal gg"
    exe "normal j"
    exe "normal llll"
endfunction
