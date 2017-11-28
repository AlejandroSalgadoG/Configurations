function! Gmcs()
    if filereadable("Makefile")
        exe "!make ".g:mkargs
        if v:shell_error
            return
        endif
        exe "!".g:cmd.expand('%:r')." ".g:args
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
