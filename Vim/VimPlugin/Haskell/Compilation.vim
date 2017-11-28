function! Ghc()
    let name=expand('%:r')
    if filereadable("Makefile")
        exe "!make ".g:mkargs

        exe "!".g:cmd.name." ".g:args
    else
        exe "normal tt"
        call MakeGhcHead(name)
        call MakeGhcClean(name)
        call MakeGhcExe(name)
        exe "normal gg"
        write Makefile
        quit
        call Ghc()
    endif
endfunction

function! MakeGhcHead(name)
    :call Make()
    exe "normal i".a:name.": ".a:name.".o\n
        \\tghc ".a:name.".o -o ".a:name."\n\n"
        \.a:name.".o: ".a:name.".".g:extension."\n
        \\tghc -c ".a:name.".".g:extension
endfunction

function! MakeGhcClean(name)
    :call Make()
    exe "normal o\nclean:\n\trm -f *.o *.hi ".a:name
endfunction

function! MakeGhcExe(name)
    exe "normal o\nexe:\n\t./".a:name
endfunction
