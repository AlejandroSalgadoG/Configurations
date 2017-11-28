function! Gpp()
    let name=expand('%:r')
    if filereadable("Makefile")
        exe "!make ".g:mkargs

        exe "!".g:cmd.name." ".g:args
    else
        exe "normal tt"
        call MakeCppHead(name)
        call MakeCppClean(name)
        call MakeCppExe(name)
        exe "normal gg"
        write Makefile
        quit
        call Gpp()
    endif
endfunction

function! MakeCppHead(name)
    :call Make()
    exe "normal i".a:name.": ".a:name.".o\n
        \\tg++ ".a:name.".o -o ".a:name."\n\n"
        \.a:name.".o: ".a:name.".".g:extension."\n
        \\tg++ -c ".a:name.".".g:extension
endfunction

function! MakeCppClean(name)
    :call Make()
    exe "normal o\nclean:\n\trm -f *.o ".a:name
endfunction

function! MakeCppExe(name)
    exe "normal o\nexe:\n\t./".a:name
endfunction
