function! Nasm()
    let name=expand('%:r')
    if filereadable("Makefile")
        
        exe "!make ".g:mkargs

        exe "!".g:cmd.name." ".g:args
    else
        exe "normal tt"
        call MakeAsmHead(name)
        call MakeAsmClean(name)
        call MakeAsmExe(name)
        exe "normal gg"
        write Makefile
        quit
        call Nasm()
    endif
endfunction

function! MakeAsmHead(name)
    :call Make()
    exe "normal i".a:name.": ".a:name.".o\n
        \\tld -m elf32_x86_64 ".a:name.".o -o ".a:name."\n\n"
        \.a:name.".o: ".a:name.".asm\n
        \\tnasm -f elfx32 ".a:name.".asm"
endfunction

function! MakeAsmClean(name)
    :call Make()
    exe "normal o\nclean:\n\trm -f *.o ".a:name
endfunction

function! MakeAsmExe(name)
    exe "normal o\nexe:\n\t./".a:name
endfunction
