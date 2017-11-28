function! Ghc()
    if filereadable("Makefile")
        exe "!make ".g:mkargs

        exe "!".g:cmd.g:name." ".g:args
    else
        exe "normal tt"
        call MakeGhcHead()
        call MakeGhcClean()
        call MakeGhcExe()
        exe "normal gg"
        write Makefile
        quit
        call Ghc()
    endif
endfunction

function! MakeGhcHead()
    :call Make()
    exe "normal i".g:name.": ".g:name.".o\n
        \\tghc ".g:name.".o -o ".g:name."\n\n"
        \.g:name.".o: ".g:name.".".g:extension."\n
        \\tghc -c ".g:name.".".g:extension
endfunction

function! MakeGhcClean()
    :call Make()
    exe "normal o\nclean:\n\trm -f *.o *.hi ".g:name
endfunction

function! MakeGhcExe()
    exe "normal o\nexe:\n\t./".g:name
endfunction
