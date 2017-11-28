function! Gpp()
    if filereadable("Makefile")
        exe "!make ".g:mkargs
        if v:shell_error
            return
        endif
        exe "!".g:cmd.expand('%:r')." ".g:args
    else
        exe "normal tt"
        call MakeCppHead()
        call MakeCppClean()
        call MakeCppExe()
        exe "normal gg"
        write Makefile
        quit
        call Gpp()
    endif
endfunction

function! MakeCppHead()
    :call Make()
    exe "normal i".g:name.": ".g:name.".o\n
        \\tg++ ".g:name.".o -o ".g:name."\n\n"
        \.g:name.".o: ".g:name.".".g:extension."\n
        \\tg++ -c ".g:name.".".g:extension
endfunction

function! MakeCppClean()
    :call Make()
    exe "normal o\nclean:\n\trm -f *.o ".g:name
endfunction

function! MakeCppExe()
    exe "normal o\nexe:\n\t./".g:name
endfunction
