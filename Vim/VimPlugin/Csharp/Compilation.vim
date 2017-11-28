function! Gmcs()
    if filereadable("Makefile")
        exe "!make ".g:mkargs

        for output in getqflist()
            if output.valid == "1"
                return
            endif
        endfor

        exe "!".g:cmd.g:name." ".g:args
    else
        exe "normal tt"
        call MakeCsharpHead()
        call MakeCsharpClean()
        call MakeCsharpExe()
        exe "normal gg"
        write Makefile
        quit
        call Gmcs()
    endif
endfunction

function! MakeCsharpHead()
    :call Make()
    exe "normal i".g:name.": "g:name.".cs\n
        \\tgmcs -out:".g:name." ".g:name.".cs\n\n"
endfunction

function! MakeCsharpClean()
    exe "normal o\nclean:\n\trm -f *.dll ".g:name
endfunction

function! MakeCsharpExe()
    exe "normal o\nexe:\n\t./".g:name
endfunction
