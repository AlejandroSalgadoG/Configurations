noremap K :call IntKernel()<enter>

function! PrintAsm()
    exe "normal o\tmov eax, 4\n
        \mov ebx, 1\n
        \mov ecx, \n
        \mov edx, 1\n
        \int 0x80"
    exe "normal kk"
endfunction

function! IntKernel()
   exe "normal aint 0x80"
endfunction
