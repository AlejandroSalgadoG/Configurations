function! Nasm()
    if filereadable("Makefile")
        exe "!make ".g:mkargs
        if v:shell_error
            return
        endif
        exe "!".g:cmd." ".g:args
    else
        exe "normal tt"
        call MakeAsmHead()
        call MakeAsmClean()
        call MakeAsmExe()
        exe "normal gg"
        write Makefile
        quit
        call Nasm()
    endif
endfunction

function! MakeAsmHead()
    :call Make()
    exe "normal i".g:name.": ".g:name.".o\n
        \\tld -m elf32_x86_64 ".g:name.".o -o ".g:name."\n\n"
        \.g:name.".o: ".g:name.".asm\n
        \\tnasm -f elfx32 ".g:name.".asm"
endfunction

function! MakeAsmClean()
    :call Make()
    exe "normal o\nclean:\n\trm -f *.o ".g:name
endfunction

function! MakeAsmExe()
    exe "normal o\nexe:\n\t./".g:name
endfunction
