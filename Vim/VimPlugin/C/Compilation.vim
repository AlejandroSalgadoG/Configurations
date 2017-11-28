function! Gcc()
    if filereadable("Makefile")
        exe "!make ".g:mkargs
        if v:shell_error
            return
        endif
        exe "!".g:cmd.expand('%:r')." ".g:args
    else
        exe "normal tt"
        call MakeCHead()
        call MakeCClean()
        call MakeCExe()
        exe "normal gg"
        write Makefile
        quit
        call Gcc()
    endif
endfunction

function! MakeCHead()
    :call Make()
    exe "normal i".g:name.": ".g:name.".o\n
        \\tgcc ".g:name.".o -o ".g:name."\n\n"
        \.g:name.".o: ".g:name.".c\n
        \\tgcc -c ".g:name.".c"
endfunction

function! MakeCClean()
    :call Make()
    exe "normal o\nclean:\n\trm -f *.o ".g:name
endfunction

function! MakeCExe()
    exe "normal o\nexe:\n\t./".g:name
endfunction
